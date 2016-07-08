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

# whether install justniffer
default['devops_basic']['whether_install_justniffer'] = 'true'

default['devops_basic']['package_list'] = \
['lsof', 'curl', 'wget', 'inotify-tools', 'bc', 'telnet', 'tar', 'tree', 'vim', \
 'git', 'tmux', 'syslinux', 'python-pip']
