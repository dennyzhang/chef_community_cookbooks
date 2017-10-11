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
