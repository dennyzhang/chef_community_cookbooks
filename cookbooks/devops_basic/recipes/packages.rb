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

# install packages
node['devops_basic']['package_list'].each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

################################################################################
if node['devops_basic']['whether_install_justniffer'] == 'true'
  # whether install justniffer
  apt_repository 'ruby2.1-repo' do
    uri 'ppa:oreste-notelli/ppa'
    distribution node['lsb']['codename']
    key 'C3173AA6'
    keyserver 'keyserver.ubuntu.com'
    retries 3
    retry_delay 3
    not_if { ::File.exist?('/etc/apt/sources.list.d/ruby2.1-repo.list') }
  end

  package 'justniffer' do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end
################################################################################
