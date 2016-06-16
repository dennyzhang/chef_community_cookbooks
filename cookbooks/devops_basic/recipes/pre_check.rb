# -*- encoding: utf-8 -*-
#
# Cookbook Name:: devops_basic
# Recipe:: pre_check
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

# TODO: implement logic

# min_cpu_count = node['devops_basic']['precheck']['all_in_one']['min_cpu_count']
# min_memory_gb = node['devops_basic']['precheck']['all_in_one']['min_memory_gb']
# free_disk = node['devops_basic']['precheck']['all_in_one']['free_disk_gb']

# # TODO: remove code duplication

# # Check enough CPU cores
# if node['cpu']['total'] < min_cpu_count.to_i
#   Chef::Application.fatal!('Low cpu: To install mdm, need at least ' + \
#                            min_cpu_count + ' cpu cores')
# end

# # Check enough memory
# total_memory = node['memory']['total'][0..-3].to_f
# total_memory /= 1024 * 1024
# if total_memory < min_memory_gb.to_f
#   Chef::Application.fatal!("Low memory: To install mdm, need at least #{min_memory_gb} " \
#                            " GB memory, while total memory is #{total_memory.round(2)}")
# end

# # Check enough disk capacity for root directory
# node['filesystem'].each do |mnt, disk|
#   next unless disk['mount'] == '/' && disk.key?('kb_available')
#   free_disk = disk['kb_available'].to_f
#   free_disk /= 1024 * 1024
#   if free_disk < free_disk.to_f
#     Chef::Application.fatal!("Free disk of \/ is only #{free_disk.round(2)}" \
#                              " GB, while at least #{free_disk}" \
#                              " GB free disk is required #{mnt}")
#   end
# end
