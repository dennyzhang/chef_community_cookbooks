# -*- encoding: utf-8 -*-

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
  mode 0o755
  action :create
end

template "#{node['chef_handler']['handler_path']}/changereport_handler.rb" do
  source 'changereport_handler.rb.erb'
  action :create
end

include_recipe 'chef_handler::default'

chef_handler 'MyChefReport::ChangReportHandler' do
  source "#{node['chef_handler']['handler_path']}/changereport_handler.rb"
  action :enable
end
