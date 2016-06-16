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

# Download bash scripts from http links
download_link_prefix = default['devops_basic']['download_link_prefix']

remote_file '/opt/devops/bin/enforce_all_nagios_check.sh' do
  source "#{download_link_prefix}/" \
         'bash/enforce_all_nagios_check/master/enforce_all_nagios_check.sh'
  owner 'root'
  group 'root'
  mode '0755'
  retries 3
end

# TODO: use fixed version and checksum mechansim
remote_file '/opt/devops/bin/wait_for.sh' do
  source "#{download_link_prefix}/" \
         'bash/wait_for/wait_for.sh'
  owner 'root'
  group 'root'
  mode '0755'
  retries 3
end

remote_file '/opt/devops/bin/create_loop_device.sh' do
  source "#{download_link_prefix}/" \
         'bash/create_loop_device.sh'
  owner 'root'
  group 'root'
  mode '0755'
  retries 3
end

remote_file '/opt/devops/bin/disable_oom.sh' do
  source "#{download_link_prefix}/" \
         'bash/disable_oom.sh'
  owner 'root'
  group 'root'
  mode '0755'
  retries 3
end

remote_file '/opt/devops/bin/free_cache.sh' do
  source "#{download_link_prefix}/" \
         'bash/free_cache.sh'
  owner 'root'
  group 'root'
  mode '0755'
  retries 3
end

remote_file '/opt/devops/bin/manage_all_services.sh' do
  source "#{download_link_prefix}/" \
         'bash/manage_all_services/manage_all_services.sh'
  owner 'root'
  group 'root'
  mode '0755'
  retries 3
end
