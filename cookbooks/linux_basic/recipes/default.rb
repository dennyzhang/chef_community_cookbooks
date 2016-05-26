# -*- encoding: utf-8 -*-
#
# Cookbook Name:: linux_basic
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

node.from_file(run_context.resolve_attribute('linux_basic', 'default'))

# include_recipe 'linux_basic::security'
# include_recipe 'linux_basic::files'
# include_recipe 'linux_basic::packages'
# include_recipe 'linux_basic::users'
# include_recipe 'linux_basic::coredump'

# include_recipe 'linux_basic::system'
# include_recipe 'linux_basic::crontab'
# include_recipe 'linux_basic::profile'

# include_recipe 'ntp'
