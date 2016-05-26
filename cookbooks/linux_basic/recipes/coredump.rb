# -*- encoding: utf-8 -*-
#
# Cookbook Name:: linux_basic
# Recipe:: coredump
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

directory '/usr/local/coredump' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end
