# -*- encoding: utf-8 -*-
#
# Cookbook Name:: devops_library
# Recipe:: install_serverspec
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
directory '/opt/serverspec' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

%w(jenkins_helper.rb common_library.rb db_helper.rb general_helper.rb).each do |x|
  cookbook_file "/opt/serverspec/#{x}" do
    source "devops_public/serverspec/#{x}"
  end
end
