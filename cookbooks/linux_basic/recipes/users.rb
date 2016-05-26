# -*- encoding: utf-8 -*-
#
# Cookbook Name:: linux_basic
# Recipe:: users
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

######################### Add ReadOnly User ###############################
if node['basic'].attribute?(:readonly_user) && node['basic']['readonly_user'] != ''
  list = node['basic']['readonly_user'].split(':')
  readonly_user_name = list[0]
  readonly_user_passwd = list[1]

  user readonly_user_name do
    supports manage_home: true
    comment 'Readonly User'
    gid 'users'
    home '/opt/#{readonly_user_name}'
    shell '/bin/bash'
    password readonly_user_passwd
  end
end
###########################################################################

######################### Add Admin User ##################################
if node['basic'].attribute?(:admin_user) && node['basic']['admin_user'] != ''
  list = node['basic']['admin_user'].split(':')
  # TODO: uid may conflict
  admin_user_name = list[0]
  admin_user_passwd = list[1]

  user admin_user_name do
    supports manage_home: true
    comment 'Admin user'
    gid 0
    home '/opt/#{admin_user_name}'
    shell '/bin/bash'
    password admin_user_passwd
  end
end
###########################################################################
