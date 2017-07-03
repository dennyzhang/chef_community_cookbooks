# -*- encoding: utf-8 -*-

#
# Cookbook Name:: devops_library
# Recipe:: enable_alias
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

# enable bash alias
cookbook_file '/etc/profile.d/mybackup.sh' do
  source 'mybackup.sh'
  owner 'root'
  group 'root'
  mode 0o755
end

# create directory for backup
%w(/data/backup).each do |x|
  directory x do
    owner 'root'
    group 'root'
    mode 0o777
    action :create
  end
end
