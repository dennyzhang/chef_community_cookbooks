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

%w(lsof curl wget inotify-tools bc telnet tar tree vim).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

%w(git tmux syslinux python-pip).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end
