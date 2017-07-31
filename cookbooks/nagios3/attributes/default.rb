# -*- encoding: utf-8 -*-
case node['platform_family']
when 'debian'
  default['nagios3']['apache_name'] = 'apache2'
  default['nagios3']['nagios_name'] = 'nagios3'
  if node['platform'] == 'ubuntu' && node['platform_version'] == '12.04'
    default['nagios3']['apache_pid_file'] = '/var/run/apache2.pid'
  else
    default['nagios3']['apache_pid_file'] = '/var/run/apache2/apache2.pid'
  end
  default['nagios3']['nrpe_name'] = 'nagios-nrpe-server'
  default['nagios3']['htpasswd_users'] = '/etc/nagios3/htpasswd.users'
  default['nagios3']['conf_erb_file'] = 'ubuntu_nagios.cfg.erb'
  default['nagios3']['command_erb_file'] = 'ubuntu_commands.cfg.erb'
  default['nagios3']['command_file'] = '/etc/nagios3/commands.cfg'
  default['nagios3']['localhost_cfg'] = '/etc/nagios3/conf.d/localhost_nagios2.cfg'
  default['nagios3']['localhost_cfg_erb'] = 'ubuntu_localhost.cfg.erb'
  default['nagios3']['plugins_dir'] = '/usr/lib/nagios/plugins'
when 'fedora', 'rhel', 'suse'
  default['nagios3']['apache_name'] = 'httpd'
  default['nagios3']['nagios_name'] = 'nagios'
  default['nagios3']['apache_pid_file'] = '/var/run/httpd/httpd.pid'
  default['nagios3']['nrpe_name'] = 'nrpe'
  default['nagios3']['htpasswd_users'] = '/etc/nagios/passwd'
  default['nagios3']['conf_erb_file'] = 'redhat_nagios.cfg.erb'
  default['nagios3']['command_erb_file'] = 'redhat_commands.cfg.erb'
  default['nagios3']['command_file'] = '/etc/nagios/objects/commands.cfg'
  default['nagios3']['plugins_dir'] = '/usr/lib64/nagios/plugins'
  default['nagios3']['localhost_cfg'] = '/etc/nagios/objects/localhost.cfg'
  default['nagios3']['localhost_cfg_erb'] = 'redhat_localhost.cfg.erb'
else
  Chef::Application.fatal!("Need to customize for OS of #{node['platform_family']}")
end

default['nagios3']['download_dir'] = '/root/download'
default['nagios3']['enable_basic_check'] = '1'
default['nagios3']['change_localhost_cfg'] = '1'

# customize this
default['nagios3']['server_ip'] = '127.0.0.1'
default['nagios3']['client_ip_list'] = '127.0.0.1'
default['nagios3']['allowed_hosts'] = ''
default['nagios3']['admin_username'] = 'nagiosadmin'
# password' password1234
default['nagios3']['admin_password_hash'] = '$1$GnGoDNzy$0m0OWNzhcGQjc8KwKZdaD/'

default['nagios3']['nagiosgraph_url'] = 'http://www.mirrorservice.org/sites/downloads.sourceforge.net/n/na/nagiosgraph/nagiosgraph/1.5.2/nagiosgraph-1.5.2.tar.gz'

# slack
default['nagios3']['slack_domain'] = ''
# When slack_token is empty, skip slack alerting in nagios
default['nagios3']['slack_token'] = ''
default['nagios3']['slack_cri_channel'] = ''
default['nagios3']['slack_all_channel'] = ''

default['nagios3']['memory_warn_threshold'] = '80'
default['nagios3']['memory_cri_threshold'] = '90'

default['nagios3']['disk_warn_threshold'] = '15'
default['nagios3']['disk_cri_threshold'] = '10'
