# -*- encoding: utf-8 -*-
default['devops_basic']['os_check'] = {
  'min_cpu_count' => '2',
  'min_memory_gb' => '3.5',
  'free_disk_gb' => '2'
}

# configure ping_server_list to empty, if we won't to skip ping check
default['devops_basic']['ping_server_list'] = ['www.bing.com']

# What OS version, current deployment supports
default['devops_basic']['supported_os_list'] = ['ubuntu-14.04']

# Note: In below, 2016-06-16 is repo's tag name
default['devops_basic']['download_link_prefix'] = \
'https://raw.githubusercontent.com/DennyZhang/devops_public/2016-06-23'
