# -*- encoding: utf-8 -*-
#
# Cookbook Name:: linux_basic
# Recipe:: system
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

# ################# hostname ###################################
# node.default['set_fqdn']='test.dennyzhang.com'
# include_recipe 'hostname'
# ##############################################################

# #################### timezone #######################
# # https://supermarket.chef.io/cookbooks/timezone-ii
# node.default['tz'] = 'America/New_York'
# include_recipe 'timezone-ii'
# #####################################################

################ /etc/hosts ##################################
# Add current hostname to /etc/hosts
ruby_block 'Current hostname in /etc/hosts' do
  block do
    file = Chef::Util::FileEdit.new('/etc/hosts')
    file.insert_line_if_no_match(
      '# Edited by Chef',
      "\n# Edited by Chef\n#{node['ipaddress']}    #{node['hostname']}"
    )
    file.write_file
  end
  not_if "grep \'#{node['ipaddress']}.*`hostname -s`\' /etc/hosts"
end

# Comment out 127.0.1.1
execute 'Comment out 17.0.1.1 from /etc/hosts' do
  command "sed -i 's/^127.0.1.1/#127.0.1.1/g' /etc/hosts"
  action :run
  only_if "grep '^127.0.1.1' /etc/hosts"
end
##############################################################

################# Sysctl #####################################
# Old Redhat/CentOS may don't have /etc/sysctl.d by default
directory '/etc/sysctl.d' do
  owner 'root'
  group 'root'
  mode 00755
end

cookbook_file '/etc/sysctl.d/60-coredump.conf' do
  source '60-coredump.conf'
  mode '0644'
end

execute 'sysctl -p /etc/sysctl.d/60-coredump.conf' do
  action :nothing
  subscribes :run, 'template[/etc/sysctl.d/60-coredump.conf]', :immediately
end

cookbook_file '/etc/security/limits.d/enable-coredump.conf' do
  source 'enable-coredump.conf'
  mode '0644'
end
##############################################################
