#
# Cookbook Name:: nagios3
# Recipe:: nagios_check
#
# Copyright 2015, DennyZhang.com
#
# Apache License, Version 2.0
#

if node['nagios']['enable_basic_check'] == '1'
  node['nagios']['client_ip_list'].split(';').each do |nagios_client_ip|
    service_check_list = []
    ########################### Common Check ##################################
    service_check_list += \
    [
      'check_total_procs:check_nrpe2!check_total_procs',
      # TODO: customize threshold
      'check_load:check_nrpe2!check_cpu_load',
      'check_users:check_nrpe2!check_users',
      'check_swap_usage:check_nrpe2!check_swap_usage',
      'check_zombie_procs:check_nrpe2!check_zombie_procs',
      # TODO: customize threshold
      'check_disk_rootfs:check_nrpe2!check_disk_rootfs',
      # TODO: customize threshold
      'check_memory:check_nrpe2!check_memory',
      # TODO: customize threshold
      'check_network_eth0:check_nrpe2!check_network_eth0'
      # 'check_ip_address:check_nrpe2!check_ip_address',
      # 'Check_Certificate:check_nrpe2!check_certificate',
      # 'check_cdn:',
      # 'check_cdn_server:',
    ]
    ###########################################################################

    # ########################### App Related Checks ##########################
    service_check_list += \
    ['check_apache_mem:check_nrpe2!check_apache_mem',
     'check_apache_fd:check_nrpe2!check_apache_fd',
     'check_apache_cpu:check_nrpe2!check_apache_cpu',
     'check_apache_log:check_nrpe2!check_apache_log'
    ]

    # if !node['servers']['apache_ip_list'].index(nagios_client_ip).nil?
    # service_check_list = service_check_list + \
    # ['check_apache_mem:check_nrpe2!check_apache_mem',
    # 'check_apache_fd:check_nrpe2!check_apache_fd',
    # 'check_apache_log:check_nrpe2!check_apache_log',
    # 'check_apache_cpu:check_nrpe2!check_apache_cpu',
    # ]
    # end

    # if !node['servers']['tomcat_ip_list'].index(nagios_client_ip).nil?
    # service_check_list = service_check_list + \
    # ['check_tomcat:check_nrpe2!check_tomcat',
    # 'check_tomcat_mem:check_nrpe2!check_tomcat_mem',
    # 'check_tomcat_fd:check_nrpe2!check_tomcat_fd',
    # 'check_tomcat_modjk:check_nrpe2!check_tomcat_modjk',
    # 'check_tomcat_log:check_nrpe2!check_tomcat_log',
    # 'check_tomcat_cpu:check_nrpe2!check_tomcat_cpu',
    # ]

    ############################################################################
    conf_folder = "/etc/#{node['nagios']['nagios_name']}/conf.d"
    template "#{conf_folder}/#{nagios_client_ip}_nagios2.cfg" do
      source 'host_nagios2.cfg.erb'
      mode 0644
      variables(
        nagios_hostname: nagios_client_ip,
        service_check_list: service_check_list
      )
      notifies :restart, "service[#{node['nagios']['nagios_name']}]", :delayed
    end
  end
end
