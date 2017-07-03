# -*- encoding: utf-8 -*-

#
# Cookbook Name:: backupdir
# Recipe:: backup_dir
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

cookbook_file '/usr/local/bin/devops_backup_dir.sh' do
  source 'devops_backup_dir.sh'
  mode '0655'
end

# TODO: define crontab
