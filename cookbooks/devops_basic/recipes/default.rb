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

# Locale
node.default['locale']['lang'] = 'en_US.UTF-8'
node.default['locale']['lc_all'] = 'en_US.UTF-8'
include_recipe 'locale'

include_recipe 'devops_basic::files'
include_recipe 'devops_basic::packages'
include_recipe 'devops_basic::os_check'
include_recipe 'devops_basic::package_version_check'

include_recipe 'devops_library::install_serverspec'
