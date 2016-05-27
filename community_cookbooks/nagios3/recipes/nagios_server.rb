#
# Cookbook Name:: nagios3
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

log "platform: #{node['platform']}"

if node['platform_family'] == 'debian' && \
   node['platform'] == 'ubuntu' && \
   node['platform_version'].to_f >= 14.04
  node.default['apache']['mpm'] = 'prefork'
end

include_recipe 'apache2'

########################### Apache Service ###############################

service node['nagios']['apache_name'] do
  action :nothing
end
###########################################################################

%w(tar bc).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

########################### Nagios Service ################################
case node['platform_family']
when 'debian'
  %w(nagios3 nagios-nrpe-plugin).each do |x|
    apt_package x do
      action :install
      not_if "dpkg -l #{x} | grep -E '^ii'"
    end
  end

  # Install necessary packages for nagios graph
  %w(librrds-perl libgd-gd2-perl net-tools).each do |x|
    apt_package x do
      action :install
      not_if "dpkg -l #{x} | grep -E '^ii'"
    end
  end

  user 'nagios' do
    gid 'www-data'
  end

  # In Ubuntu, add url alias for http://$server/nagios to /nagios3
  template "/etc/#{node['nagios']['nagios_name']}/apache2.conf" do
    source 'ubuntu_nagios_apache2.conf.erb'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['nagios']['apache_name']}]", :delayed
  end

when 'fedora', 'rhel', 'suse'
  %w(nagios nagios-plugins-all).each do |x|
    yum_package x do
      action :install
    end
  end

  # Install necessary packages for nagios graph
  %w(rrdtool-perl rrdtool-php rrdtool).each do |x|
    yum_package x do
      action :install
    end
  end

  %w(perl-GD php-gd perl-CGI perl-Time-HiRes).each do |x|
    yum_package x do
      action :install
    end
  end

  # In Ubuntu, add url alias for http://$server/nagios to /nagios3
  template "/etc/#{node['nagios']['nagios_name']}/apache2.conf" do
    source 'centos_nagios_apache2.conf.erb'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['nagios']['apache_name']}]", :delayed
  end

else
  Chef::Application.fatal!("Not supported OS: #{node['platform_family']}")
end

# Nagios: enable external commands
template '/etc/' + node['nagios']['nagios_name'] + '/nagios.cfg' do
  source node['nagios']['conf_erb_file']
  owner 'root'
  group 'root'
  mode 0644
  variables(check_external_commands: '1')
  notifies :restart, "service[#{node['nagios']['apache_name']}]", :delayed
end

# nagios commands.cfg
template node['nagios']['command_file'] do
  source node['nagios']['command_erb_file']
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[#{node['nagios']['nagios_name']}]", :delayed
end

# localhost_nagios cfg
template node['nagios']['localhost_cfg'] do
  source node['nagios']['localhost_cfg_erb']
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[#{node['nagios']['nagios_name']}]", :delayed
  only_if { node['nagios']['change_localhost_cfg'] == '1' }
end

directory '/var/log/apache2/' do
  mode '0755'
  owner 'root'
  group 'root'
  action :create
end

file '/var/log/apache2/error.log' do
  mode '0755'
  action :create
end

directory '/var/lib/nagios3/' do
  mode '0750'
  owner 'nagios'
  group 'nagios'
  action :create
end

template node['nagios']['htpasswd_users'] do
  source 'htpasswd.users.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(nagios_admin_username: node['nagios']['admin_username'],
            nagios_admin_password_hash: node['nagios']['admin_password_hash'])
  notifies :restart, "service[#{node['nagios']['apache_name']}]", :delayed
end

include_recipe 'nagios3::nagios_check'

############################# Nagios Graph ################################
directory node['nagios']['download_dir'] do
  mode '07555'
  owner 'root'
  group 'root'
  action :create
end

nagiosgraph_tar = 'nagiosgraph.tar.gz'
remote_file 'Download nagiosgraph Tarball' do
  path "#{node['nagios']['download_dir']}/#{nagiosgraph_tar}"
  source node['nagios']['nagiosgraph_url']
  retries 3
  use_last_modified true
  action :create_if_missing
  notifies :run, 'execute[Unpack nagiosgraph Tarball]', :immediately
end

execute 'Unpack nagiosgraph Tarball' do
  command "tar -xf #{node['nagios']['download_dir']}/#{nagiosgraph_tar}"
  action :run
  cwd node['nagios']['download_dir']
  notifies :run, 'execute[Deploy nagiosgraph]', :immediately
end

execute 'Deploy nagiosgraph' do
  command <<-EOF
 mkdir -p /usr/local/nagiosgraph/cgi
 mkdir -p /usr/local/nagiosgraph/bin
 mkdir -p /usr/local/nagiosgraph/share
 /bin/cp -vrf etc /usr/local/nagiosgraph/
 sed -i 's#/opt/nagiosgraph/etc#/usr/local/nagiosgraph/etc/#g' cgi/*cgi
 sed -i 's#/opt/nagiosgraph/etc#/usr/local/nagiosgraph/etc/#g' lib/insert.pl
 /bin/cp cgi/*.cgi /usr/local/nagiosgraph/cgi/
 /bin/cp lib/insert.pl /usr/local/nagiosgraph/bin/
 /bin/cp share/nagiosgraph.css /usr/local/nagiosgraph/share/
 /bin/cp share/nagiosgraph.js /usr/local/nagiosgraph/share/
 EOF
  cwd "#{node['nagios']['download_dir']}/nagiosgraph-1.5.2"
  action :nothing
  not_if { ::File.exist?('/usr/local/nagiosgraph/bin/insert.pl') }
end

directory '/usr/local/nagiosgraph/var/rrd/' do
  mode '0755'
  owner 'nagios'
  group 'nagios'
  recursive true
  action :create
end

directory '/usr/local/nagiosgraph/etc/' do
  mode '0755'
  owner 'nagios'
  group 'nagios'
  recursive true
  action :create
end

template '/usr/local/nagiosgraph/etc/nagiosgraph.conf' do
  source 'nagiosgraph.conf.erb'
  owner 'nagios'
  group 'nagios'
  notifies :restart, "service[#{node['nagios']['nagios_name']}]", :delayed
end

# Apache virtual host for graphed service
template "/etc//#{node['nagios']['apache_name']}/conf-enabled/nagiosgraph.conf" do
  source 'httpd_nagiosgraph.conf'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, "service[#{node['nagios']['apache_name']}]", :delayed
end

case node['platform_family']
when 'debian'
  # define graphed-service
  template "/etc/#{node['nagios']['nagios_name']}/conf.d/services_nagios2.cfg" do
    source 'ubuntu_services_nagios2.cfg.erb'
    owner 'root'
    group 'root'
    mode 0644
    notifies :restart, "service[#{node['nagios']['nagios_name']}]", :delayed
  end

  template "/etc/#{node['nagios']['nagios_name']}/conf.d/extinfo_nagios2.cfg" do
    source 'ubuntu_extinfo_nagios2.cfg.erb'
    owner 'root'
    group 'root'
    mode 0644
    notifies :restart, "service[#{node['nagios']['nagios_name']}]", :delayed
  end

  template "/etc/#{node['nagios']['nagios_name']}/conf.d/hostgroups_nagios2.cfg" do
    source 'ubuntu_hostgroups_nagios2.cfg.erb'
    owner 'root'
    group 'root'
    mode 0644
    notifies :restart, "service[#{node['nagios']['nagios_name']}]", :delayed
  end

when 'fedora', 'rhel', 'suse'
  # define graphed-service
  template "/etc/#{node['nagios']['nagios_name']}/objects/templates.cfg" do
    source 'redhat_templates.cfg.erb'
    owner 'root'
    group 'root'
    mode 0644
    notifies :restart, "service[#{node['nagios']['nagios_name']}]", :delayed
  end
else
  Chef::Application.fatal!("Need to customize for OS of #{node['platform_family']}")
end

############################# Enable vhost ################################
link "/etc/#{node['nagios']['apache_name']}/conf-enabled/nagios3.conf" do
  to "/etc/#{node['nagios']['nagios_name']}/apache2.conf"
end

############################# Nagios Service ##############################
service node['nagios']['nagios_name'] do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
###########################################################################
