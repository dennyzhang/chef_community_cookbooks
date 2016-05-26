#
# Cookbook Name:: nagios3
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

case node['platform_family']
when 'debian'
  include_recipe 'apt'
when 'fedora', 'rhel', 'suse'
  include_recipe 'yum-epel'
  %w(nagios nagios-plugins-all).each do |x|
    package x do
      action :install
    end
  end
end

if !node['nagios']['server_ip'].index(node['ipaddress']).nil? || \
   !node['nagios']['server_ip'].index('localhost').nil? || \
   !node['nagios']['server_ip'].index('127.0.0.1').nil?
  include_recipe 'nagios3::nagios_server'
end

if !node['nagios']['client_ip_list'].index(node['ipaddress']).nil? || \
   !node['nagios']['client_ip_list'].index('localhost').nil? || \
   !node['nagios']['client_ip_list'].index('127.0.0.1').nil?
  include_recipe 'nagios3::nagios_client'
  include_recipe 'nagios3::nagios_check'
end
