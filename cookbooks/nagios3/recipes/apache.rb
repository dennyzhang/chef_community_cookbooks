#
# Cookbook Name:: nagios3
# Recipe:: apache
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
