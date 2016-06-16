# -*- encoding: utf-8 -*-
#
# Cookbook Name:: devops_basic
# Recipe:: pre_check
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
min_cpu_count = node['devops_basic']['os_check']['min_cpu_count']
min_memory_gb = node['devops_basic']['os_check']['min_memory_gb']
free_disk = node['devops_basic']['os_check']['free_disk_gb']

# Check OS version
os_version = "#{node['platform']}-#{node['platform_version']}"
supported_os_list = node['devops_basic']['supported_os_list']
unless supported_os_list.include? os_version
  Chef::Application.fatal!("Current OS version is #{os_version}. " \
                           "Supported OS versions: #{supported_os_list.join(',')}")
end

# Check dns and outbound network
node['devops_basic']['ping_server_list'].each do |ping_server|
  ruby_block 'Check network connectivity' do
    block do
      Chef::Application.fatal!("ERROR: fail to ping #{ping_server}")
    end
    not_if "ping -c2 #{ping_server}"
  end
end

################################################################################
# Check enough CPU cores
if node['cpu']['total'] < min_cpu_count.to_i
  Chef::Application.fatal!('Low cpu: To install mdm, need at least ' + \
                           min_cpu_count + ' cpu cores')
end

# Check enough memory
total_memory = node['memory']['total'][0..-3].to_f
total_memory /= 1024 * 1024
if total_memory < min_memory_gb.to_f
  Chef::Application.fatal!("Low memory: To install mdm, need at least #{min_memory_gb} " \
                           " GB memory, while total memory is #{total_memory.round(2)}")
end

# Check enough disk capacity for root directory
node['filesystem'].each do |mnt, disk|
  next unless disk['mount'] == '/' && disk.key?('kb_available')
  free_disk = disk['kb_available'].to_f
  free_disk /= 1024 * 1024
  if free_disk < free_disk.to_f
    Chef::Application.fatal!("Free disk of \/ is only #{free_disk.round(2)}" \
                             " GB, while at least #{free_disk}" \
                             " GB free disk is required #{mnt}")
  end
end
