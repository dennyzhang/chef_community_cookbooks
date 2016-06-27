# -*- encoding: utf-8 -*-
#
# Cookbook Name:: justniffer
# Recipe:: start
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

start_command = "nohup /usr/bin/justniffer -i #{node['justniffer']['eth_nic']} " \
          "-l '%request.timestamp(%T %D) %request.header.host - %response.time' " \
          ">> #{node['justniffer']['traffic_log_file']} 2>&1 &"

execute 'Start justniffer' do
  command start_command
  action :run
  not_if 'pgrep justniffer'
end
