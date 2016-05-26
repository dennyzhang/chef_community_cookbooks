#
# Cookbook Name:: chef_changereport_handler
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
working_dir = node['chef_changereport_handler']['working_dir']
directory working_dir do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end


template "#{node["chef_handler"]["handler_path"]}/changereport_handler.rb" do
  source 'changereport_handler.rb.erb'
  action :create
end

include_recipe 'chef_handler::default'

chef_handler 'MyChefReport::ChangReportHandler' do
  source "#{node["chef_handler"]["handler_path"]}/changereport_handler.rb"
  action :enable
end

logrotate_app 'changereport_chef_handler' do
  cookbook 'logrotate'
  path "#{working_dir}/history.txt"
  frequency 'monthly'
  rotate 7
  create '644 root adm'
end
