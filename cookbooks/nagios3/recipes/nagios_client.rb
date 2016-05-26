#
# Cookbook Name:: nagios3
# Recipe:: nagios_client
#
# Copyright 2015, DennyZhang.com
#
# Apache License, Version 2.0
#

case node['platform_family']
when 'debian'
  ['nagios-nrpe-server', 'nagios-plugins', 'nagios-nrpe-plugin', \
   'nagios-plugins-basic', 'libsys-statistics-linux-perl'].each do |x|
    apt_package x do
      action :install
      not_if "dpkg -l #{x} | grep -E '^ii'"
    end
  end
when 'fedora', 'rhel', 'suse'
  %w(nagios-plugins-nrpe nagios-plugins-all nrpe perl-Sys-Statistics-Linux).each do |x|
    yum_package x do
      action :install
    end
  end
else
  Chef::Application.fatal!("Need to customize for OS of #{node['platform_family']}")
end

# Make sure nagios user to run admin commands like lsof without problem
file '/etc/sudoers.d/nagios' do
  mode '0440'
  content '%nagios ALL=(ALL:ALL) NOPASSWD: ALL'
end

###################### Install Basic Files for Checks #####################
remote_directory '/etc/nagios/log_cfg' do
  files_mode '0755'
  files_owner 'root'
  mode '0755'
  owner 'root'
  source 'log_cfg'
end
###########################################################################

######################## nagios check plugins ##########################
directory '/etc/nagios/nrpe.d' do
  owner 'root'
  group 'root'
  mode 0755
  recursive true
  action :create
end

allowed_hosts = node['nagios']['allowed_hosts']

if node['nagios']['allowed_hosts'].index(node['nagios']['server_ip']).nil?
  if allowed_hosts == ''
    allowed_hosts = node['nagios']['server_ip']
  else
    allowed_hosts = allowed_hosts + ',' + node['nagios']['server_ip']
  end
end

template '/etc/nagios/nrpe.cfg' do
  source 'nrpe.cfg.erb'
  owner 'root'
  group 'root'
  mode 0755
  variables(
    allowed_hosts: allowed_hosts
  )
  notifies :restart, "service[#{node['nagios']['nrpe_name']}]", :delayed
end

template '/etc/nagios/nrpe.d/common_nrpe.cfg' do
  source 'common_nrpe.cfg.erb'
  owner 'root'
  group 'root'
  mode 0755
  variables(
    nagios_plugins: node['nagios']['plugins_dir']
  )
  notifies :restart, "service[#{node['nagios']['nrpe_name']}]", :delayed
end

template '/etc/nagios/nrpe.d/my_nrpe.cfg' do
  source 'my_nrpe.cfg.erb'
  owner 'root'
  group 'root'
  mode 0755
  variables(
    apache_pid_file: node['nagios']['apache_pid_file'],
    nagios_plugins: node['nagios']['plugins_dir']
  )
  notifies :restart, "service[#{node['nagios']['nrpe_name']}]", :delayed
end

template '/etc/nagios/nrpe.d/check_logfile.cfg' do
  source 'check_logfile.cfg.erb'
  owner 'root'
  group 'root'
  mode 0755
  variables(
    nagios_plugins: node['nagios']['plugins_dir']
  )
  notifies :restart, "service[#{node['nagios']['nrpe_name']}]", :delayed
end

directory node['nagios']['plugins_dir'] do
  owner 'root'
  group 'root'
  mode 0755
  recursive true
  action :create
end

proc_nagios_plugin = 'check_proc_mem'
checksum = '1c4a4f5d624b911ec38bf8ec920a58e19c106ee3f063b529a226e536df6a6f64'
git_url = 'https://raw.githubusercontent.com/DennyZhang'

remote_file "#{node['nagios']['plugins_dir']}/#{proc_nagios_plugin}.sh" do
  source "#{git_url}/#{proc_nagios_plugin}/master/#{proc_nagios_plugin}.sh"
  owner 'nagios'
  group 'nagios'
  mode '0755'
  checksum checksum
  retries 3
end

proc_nagios_plugin = 'check_proc_cpu'
checksum = '710483595cd4786dd3477aa13584cd842b8a761b51d04f1d5c680756b12696e1'
remote_file "#{node['nagios']['plugins_dir']}/#{proc_nagios_plugin}.sh" do
  source "#{git_url}/#{proc_nagios_plugin}/master/#{proc_nagios_plugin}.sh"
  owner 'nagios'
  group 'nagios'
  mode '0755'
  checksum checksum
  retries 3
end

proc_nagios_plugin = 'check_proc_fd'
checksum = '35875219b953257dcc1774ce51e7a0fe1b5d58cf7857e2ea1171676c5a7ce67b'
remote_file "#{node['nagios']['plugins_dir']}/#{proc_nagios_plugin}.sh" do
  source "#{git_url}/#{proc_nagios_plugin}/master/#{proc_nagios_plugin}.sh"
  owner 'nagios'
  group 'nagios'
  mode '0755'
  checksum checksum
  retries 3
end

%w(check_linux_stats.pl check_ip_address.sh).each do |x|
  template "#{node['nagios']['plugins_dir']}/#{x}" do
    source "#{x}.erb"
    owner 'root'
    group 'root'
    mode 0755
  end
end

# ######################### selenium_test ################################
# remote_file '/opt/selenium-server-standalone-2.38.0.jar' do
# source 'https://selenium.googlecode.com/files/selenium-server-standalone-2.38.0.jar'
# use_last_modified true
# mode '0755'
# action :create_if_missing
# end

########################################################################
# Install plugin
%w(check_logfiles check_service_status.sh).each do |x|
  cookbook_file "#{node['nagios']['plugins_dir']}/#{x}" do
    source x
    mode '0755'
  end
end

service node['nagios']['nrpe_name'] do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

user 'nagios' do
  shell '/bin/bash'
end
