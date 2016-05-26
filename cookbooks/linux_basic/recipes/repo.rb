# -*- encoding: utf-8 -*-
#
# Cookbook Name:: linux_basic
# Recipe:: repo
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

case node['platform_family']
when 'debian'
  include_recipe 'apt'
when 'fedora', 'rhel', 'suse'
  include_recipe 'yum-epel'
  %w(nagios nagios-plugins-all).each do |x|
    package x do
      action :install
    end
  end
end
