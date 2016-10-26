# Encoding: utf-8
require 'serverspec'
require 'json'

# Required by serverspec
set :backend, :exec

chef_data = JSON.parse(IO.read('/tmp/kitchen/dna.json'))
ssh_disable_passwd_login = \
  chef_data.fetch('general_security').fetch('ssh_disable_passwd_login')

ssh_disable_root_login = \
  chef_data.fetch('general_security').fetch('ssh_disable_root_login')

if ssh_disable_passwd_login == 'true'
  describe file('/etc/ssh/sshd_config') do
    it { should contain 'PasswordAuthentication no' }
  end
end

if ssh_disable_root_login == 'true'
  describe file('/etc/ssh/sshd_config') do
    it { should contain 'PermitRootLogin without-password' }
  end
end
