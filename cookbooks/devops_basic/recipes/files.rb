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
  /usr/local/var /usr/local/var/run /var/chef /var/chef/cache
  /opt/devops /opt/devops/bin /data
).each do |x|
  directory x do
    owner 'root'
    group 'root'
    mode 0o755
    action :create
  end
end

%w(/data/backup).each do |x|
  directory x do
    owner 'root'
    group 'root'
    mode 0o777
    action :create
  end
end

cookbook_file '/opt/devops/bin/parse_log_for_errmsg.py' do
  source 'devops_public/python/parse_log_for_errmsg/parse_log_for_errmsg.py'
  owner 'root'
  group 'root'
  mode 0o755
  cookbook 'devops_library'
end

cookbook_file '/opt/devops/bin/enforce_all_nagios_check.sh' do
  source 'devops_public/bash/enforce_all_nagios_check/enforce_all_nagios_check.sh'
  owner 'root'
  group 'root'
  mode 0o755
  cookbook 'devops_library'
end

cookbook_file '/opt/devops/bin/create_loop_device.sh' do
  source 'devops_public/bash/create_loop_device.sh'
  owner 'root'
  group 'root'
  mode 0o755
  cookbook 'devops_library'
end

cookbook_file '/opt/devops/bin/disable_oom.sh' do
  source 'devops_public/bash/disable_oom.sh'
  owner 'root'
  group 'root'
  mode 0o755
  cookbook 'devops_library'
end

cookbook_file '/opt/devops/bin/free_cache.sh' do
  source 'devops_public/bash/free_cache.sh'
  owner 'root'
  group 'root'
  mode 0o755
  cookbook 'devops_library'
end

cookbook_file '/opt/devops/bin/manage_all_services.sh' do
  source 'devops_public/bash/manage_all_services/manage_all_services.sh'
  owner 'root'
  group 'root'
  mode 0o755
  cookbook 'devops_library'
end

cookbook_file '/opt/devops/bin/wait_for.sh' do
  source 'devops_public/bash/wait_for/wait_for.sh'
  owner 'root'
  group 'root'
  mode 0o755
  cookbook 'devops_library'
end

cookbook_file '/opt/devops/bin/docker_destroy.sh' do
  source 'devops_public/bash/docker_facility/docker_destroy.sh'
  owner 'root'
  group 'root'
  mode 0o755
  cookbook 'devops_library'
end

cookbook_file '/opt/devops/bin/cleanup_old_files.py' do
  source 'devops_public/python/cleanup_old_files/cleanup_old_files.py'
  owner 'root'
  group 'root'
  mode 0o755
  cookbook 'devops_library'
end
