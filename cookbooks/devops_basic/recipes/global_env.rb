# -*- encoding: utf-8 -*-
#
# Cookbook Name:: devops_basic
# Recipe:: global_env
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
execute 'Add Date and Time to Bash History' do
  command "echo \"export HISTTIMEFORMAT='%h %d %H:%M:%S '\" >> /root/.bashrc"
  action :run
  not_if "grep 'export HISTTIMEFORMAT=' /root/.bashrc"
end
