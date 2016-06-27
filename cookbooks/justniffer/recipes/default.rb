# -*- encoding: utf-8 -*-
#
# Cookbook Name:: justniffer
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
include_recipe 'apt::default'

apt_repository 'justniffer-repo' do
  uri 'ppa:oreste-notelli/ppa'
  distribution node['lsb']['codename']
  key 'E404C48A'
  keyserver 'keyserver.ubuntu.com'
  retries 3
  retry_delay 3
  not_if { ::File.exist?('/etc/apt/sources.list.d/oreste-notelli-ppa-trusty.list') }
end

%w(justniffer).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end
