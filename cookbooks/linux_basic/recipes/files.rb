# -*- encoding: utf-8 -*-
#
# Cookbook Name:: linux_basic
# Recipe:: files
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

node.from_file(run_context.resolve_attribute('linux_basic', 'default'))

directory node['basic']['download_dir'] do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

directory '/var/log/chef/' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end
