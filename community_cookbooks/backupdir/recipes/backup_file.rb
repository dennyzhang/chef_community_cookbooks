# -*- encoding: utf-8 -*-
#
# Cookbook Name:: backupdir
# Recipe:: backup_file
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

cookbook_file '/usr/local/bin/devops_backup_file.sh' do
  source 'devops_backup_file.sh'
  mode '0655'
end

# TODO: define crontab
