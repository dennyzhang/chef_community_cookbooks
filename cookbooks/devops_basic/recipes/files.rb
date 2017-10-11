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

%w(/data/backup /var/lib/devops).each do |x|
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

remote_file '/opt/devops/bin/cleanup_old_files.py' do
  source 'https://raw.githubusercontent.com/DennyZhang/'\
         'cleanup_old_files/tag_v1/cleanup_old_files.py'
  owner 'root'
  group 'root'
  mode '0755'
  checksum '87eff40807a7b20a18883e00804111d1a7de840a149f848e58e7f22bbde1e208'
  retries 3
  retry_delay 3
end

%w(examine_hosts_file.py update_hosts_file.py).each do |x|
  cookbook_file "/usr/sbin/#{x}" do
    source "devops_public/python/hosts_file/#{x}"
    owner 'root'
    group 'root'
    mode 0o755
    cookbook 'devops_library'
  end
end
