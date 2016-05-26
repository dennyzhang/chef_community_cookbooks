case node['platform_family']
when 'debian'
  default['nagios']['apache_name'] = 'apache2'
  default['nagios']['nagios_name'] = 'nagios3'
  if node['platform'] == 'ubuntu' && node['platform_version'] == '12.04'
    default['nagios']['apache_pid_file'] = '/var/run/apache2.pid'
  else
    default['nagios']['apache_pid_file'] = '/var/run/apache2/apache2.pid'
  end
  default['nagios']['nrpe_name'] = 'nagios-nrpe-server'
  default['nagios']['htpasswd_users'] = '/etc/nagios3/htpasswd.users'
  default['nagios']['conf_erb_file'] = 'ubuntu_nagios.cfg.erb'
  default['nagios']['command_erb_file'] = 'ubuntu_commands.cfg.erb'
  default['nagios']['command_file'] = '/etc/nagios3/commands.cfg'
  default['nagios']['localhost_cfg'] = '/etc/nagios3/conf.d/localhost_nagios2.cfg'
  default['nagios']['localhost_cfg_erb'] = 'ubuntu_localhost.cfg.erb'
  default['nagios']['plugins_dir'] = '/usr/lib/nagios/plugins'
when 'fedora', 'rhel', 'suse'
  default['nagios']['apache_name'] = 'httpd'
  default['nagios']['nagios_name'] = 'nagios'
  default['nagios']['apache_pid_file'] = '/var/run/httpd/httpd.pid'
  default['nagios']['nrpe_name'] = 'nrpe'
  default['nagios']['htpasswd_users'] = '/etc/nagios/passwd'
  default['nagios']['conf_erb_file'] = 'redhat_nagios.cfg.erb'
  default['nagios']['command_erb_file'] = 'redhat_commands.cfg.erb'
  default['nagios']['command_file'] = '/etc/nagios/objects/commands.cfg'
  default['nagios']['plugins_dir'] = '/usr/lib64/nagios/plugins'
  default['nagios']['localhost_cfg'] = '/etc/nagios/objects/localhost.cfg'
  default['nagios']['localhost_cfg_erb'] = 'redhat_localhost.cfg.erb'
else
  Chef::Application.fatal!("Need to customize for OS of #{node['platform_family']}")
end

default['nagios']['download_dir'] = '/root/download'
default['nagios']['enable_basic_check'] = '1'
default['nagios']['change_localhost_cfg'] = '1'

# customize this
default['nagios']['server_ip'] = '127.0.0.1'
default['nagios']['client_ip_list'] = '127.0.0.1'
default['nagios']['allowed_hosts'] = ''
default['nagios']['admin_username'] = 'nagiosadmin'
# password' password1234
default['nagios']['admin_password_hash'] = '$1$GnGoDNzy$0m0OWNzhcGQjc8KwKZdaD/'

default['nagios']['nagiosgraph_url'] = 'http://www.mirrorservice.org/sites/downloads.sourceforge.net/n/na/nagiosgraph/nagiosgraph/1.5.2/nagiosgraph-1.5.2.tar.gz'
