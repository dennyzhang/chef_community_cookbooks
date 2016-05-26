# -*- encoding: utf-8 -*-
#
# Cookbook Name:: linux_basic
# Recipe:: crontab
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

#################### daily rotate ###################
cron 'chef_daily_clean' do
  user 'root'
  hour '4'
  minute '0'
  command 'bash -e /usr/local/bin/chef_daily_clean.sh'
end

cron 'cron_clean_memory' do
  user 'root'
  hour '4'
  minute '0'
  command '/usr/local/bin/chef_daily_clean_memory.sh'
end

#####################################################

#################### backup cron ####################
cron 'chef_backup' do
  user 'root'
  hour '2'
  minute '0'
  command '/usr/local/bin/chef_daily_backup.sh'
end
