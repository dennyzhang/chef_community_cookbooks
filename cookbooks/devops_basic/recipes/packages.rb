# -*- encoding: utf-8 -*-
#
# Cookbook Name:: devops_basic
# Recipe:: packages
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
include_recipe 'apt::default'

%w(lsof inotify-tools telnet tar tree vim).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

%w(curl git tmux syslinux bc python-pip).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end
