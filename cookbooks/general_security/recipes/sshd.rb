#
# Cookbook Name:: general_security
# Recipe:: sshd
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

# sed -i 's/PermitRootLogin .*/PermitRootLogin without-password/' /etc/ssh/sshd_config
if node['general_security']['ssh_disable_passwd_login'] == 'true'
  execute 'SSH disable password login' do
    command 'sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/g" '\
            '/etc/ssh/sshd_config'
    action :run
    only_if 'grep "PasswordAuthentication yes" /etc/ssh/sshd_config'
  end
end

if node['general_security']['ssh_disable_root_login'] == 'true'
  execute 'SSH disable root login' do
    command 'sed -i "s/PermitRootLogin yes/PermitRootLogin without-password/g" '\
            '/etc/ssh/sshd_config'
    action :run
    only_if 'grep "PermitRootLogin yes" /etc/ssh/sshd_config'
  end
end

# TODO: SSH configure gateway
