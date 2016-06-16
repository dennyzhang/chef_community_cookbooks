# -*- encoding: utf-8 -*-
#
# Cookbook Name:: devops_basic
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
include_recipe 'apt::default'

include_recipe 'devops_basic::files'
include_recipe 'devops_basic::packages'
include_recipe 'devops_basic::os_check'
include_recipe 'devops_basic::package_version_check'
