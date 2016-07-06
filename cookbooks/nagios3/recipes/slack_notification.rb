# -*- encoding: utf-8 -*-
#
# Cookbook Name:: nagios-mdm
# Recipe:: slack_notification
#
# Copyright 2015, TOTVS Labs
#
# All rights reserved - Do Not Redistribute
#
%w(libwww-perl libcrypt-ssleay-perl).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

# https://github.com/tinyspeck/services-examples/blob/master/nagios.pl
template '/usr/local/bin/slack_nagios.pl' do
  source 'nagios.pl'
  mode 0755
end

cookbook_file '/etc/nagios3/conf.d/slack_nagios.cfg' do
  source 'slack_nagios.cfg'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[nagios3]', :delayed
end