# -*- encoding: utf-8 -*-
#
# Cookbook Name:: justniffer
# Recipe:: stop
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

execute 'Stop justniffer' do
  command 'killall justniffer'
  action :run
  only_if 'pgrep justniffer'
end
