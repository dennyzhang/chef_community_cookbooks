# -*- encoding: utf-8 -*-
#
# Cookbook Name:: devops_basic
# Recipe:: files
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
%w(
  /usr/local/var /usr/local/var/run
  /opt/devops /opt/devops/bin /data).each do |x|
  directory x do
    owner 'root'
    group 'root'
    mode 00755
    action :create
  end
end

%w(/data/backup).each do |x|
  directory x do
    owner 'root'
    group 'root'
    mode 00777
    action :create
  end
end

%w(disable_oom.sh free_cache.sh create_loop_device.sh).each do |x|
  cookbook_file "/opt/devops/bin/#{x}" do
    source x
    mode 0755
  end
end

# TODO: change location to /opt/devops/bin/
remote_file '/usr/local/bin/enforce_all_nagios_check.sh' do
  source 'https://raw.githubusercontent.com/DennyZhang/' \
         'enforce_all_nagios_check/master/enforce_all_nagios_check.sh'
  owner 'root'
  group 'root'
  mode '0755'
  retries 3
end

# TODO: use fixed version and checksum mechansim
remote_file '/opt/devops/bin/wait_for.sh' do
  source 'https://raw.githubusercontent.com/DennyZhang/' \
         'devops_public/master/bash/wait_for/wait_for.sh'
  owner 'root'
  group 'root'
  mode '0755'
  retries 3
end

remote_file '/opt/devops/bin/manage_all_services.sh' do
  source 'https://raw.githubusercontent.com/DennyZhang/' \
         'devops_public/master/bash/manage_all_services/manage_all_services.sh'
  owner 'root'
  group 'root'
  mode '0755'
  retries 3
end
