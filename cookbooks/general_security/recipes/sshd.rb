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

  execute 'SSH explictly disable password login' do
    command 'sed -i "s/^#PasswordAuthentication no$/PasswordAuthentication no/g" '\
            '/etc/ssh/sshd_config'
    action :run
    only_if 'grep "^#PasswordAuthentication no$" /etc/ssh/sshd_config'
  end
end

if node['general_security']['ssh_disable_root_login'] == 'true'
  execute 'SSH disable root login' do
    command 'sed -i "s/PermitRootLogin yes/PermitRootLogin without-password/g" '\
            '/etc/ssh/sshd_config'
    action :run
    only_if 'grep "PermitRootLogin yes" /etc/ssh/sshd_config'
  end

  execute 'SSH explicty disable root login' do
    command 'sed -i "s/^#PermitRootLogin without-password$/PermitRootLogin ' \
            'without-password/g" /etc/ssh/sshd_config'
    action :run
    only_if 'grep "^#PermitRootLogin without-password$" /etc/ssh/sshd_config'
  end
end

# sshd use secured ciphers stream
ciphers_stream = node['general_security']['ssh_ciphers_stream']
if ciphers_stream != ''
  execute 'SSHD inject cipher section if missing' do
    command "echo -e \"\nCiphers #{ciphers_stream}\" >> "\
            '/etc/ssh/sshd_config'
    action :run
    not_if "grep '^Ciphers .*' /etc/ssh/sshd_config"
  end

  execute 'SSHD update cipher streams' do
    command "sed -i \"s/^Ciphers .*/Ciphers #{ciphers_stream}/g\" "\
            ' /etc/ssh/sshd_config'
    action :run
    not_if "grep \"Ciphers #{ciphers_stream}\" /etc/ssh/sshd_config"
  end
end

# sshd use secured MACs algorithms
macs_algorithms = node['general_security']['ssh_macs_algorithms']
if macs_algorithms != ''
  execute 'SSHD inject MACs algorithms section if missing' do
    command "echo -e \"\nMACs #{macs_algorithms}\" >> "\
            '/etc/ssh/sshd_config'
    action :run
    not_if "grep '^MACs .*' /etc/ssh/sshd_config"
  end

  execute 'SSHD update MACs algorithms' do
    command "sed -i \"s/^MACs .*/MACs #{macs_algorithms}/g\" "\
            '/etc/ssh/sshd_config'
    action :run
    not_if "grep \"MACs #{macs_algorithms}\" /etc/ssh/sshd_config"
  end
end

# TODO: SSH configure gateway
