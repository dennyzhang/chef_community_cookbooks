module PreCheck
  # TODO: use a well-known ruby library to enforce the check logic

  # Precheck for input parameters and infrastructure layer
  module HelperInputFormat
    # Parmaeter checks for input format

    def check_string_not_empty(value, extra_msg)
      return unless value == ''
      err_msg = "Error: parameter is empty. #{extra_msg}"
      Chef::Application.fatal!(err_msg)
    end

    def check_ip_format(ip_address, extra_msg = '')
      block = /\d{,2}|1\d{2}|2[0-4]\d|25[0-5]/
      re = /\A#{block}\.#{block}\.#{block}\.#{block}\z/

      return unless ip_address != ''
      return unless ip_address != 'localhost'
      return unless (re =~ ip_address).nil?
      err_msg = "Error: invalid ip address #{ip_address}.#{extra_msg}"
      Chef::Application.fatal!(err_msg)
    end

    def check_ip_list_format(ip_address_list)
      # TODO: improve the error message
      # extra_msg = "#{extra_msg} is not a valid ip list" if extra_msg != ''

      ip_address_list.each do |ip_address|
        check_ip_format(ip_address)
      end
    end

    # make sure node name is valid. Doesn't have special characters like ',', ';', etc
    def check_nodename_format(node_name, extra_msg = '')
      return unless !node_name.index(',').nil? || !node_name.index(';').nil?
      err_msg = "Error: invalid node name #{node_name}.#{extra_msg}"
      Chef::Application.fatal!(err_msg)
    end

    def check_nodename_list_format(node_name_list)
      # TODO: improve the error message
      # extra_msg = "#{extra_msg} is not a valid ip list" if extra_msg != ''

      node_name_list.each do |node_name|
        check_nodename_format(node_name)
      end
    end

    def check_tcp_port_format(tcp_port, extra_msg)
      # TODO: to be implemented
    end

    def check_int_format(ip_address)
      # TODO: to be implemented
    end
  end

  ################################################################################
  # Infra checks before update
  module HelperInfraCheck
    def check_capacity_cpu(min_cpu_count, current_cpu_count)
      # Check enough CPU cores
      return unless current_cpu_count < min_cpu_count.to_i
      Chef::Application.fatal!('Low cpu: the machine should have at least ' + \
                               min_cpu_count + ' cpu cores')
    end

    def check_capacity_ram(min_ram_gb, current_ram_gb)
      return unless current_ram_gb < min_ram_gb.to_f
      Chef::Application.fatal!('Low memory: the machine should have at least ' \
                               "#{min_ram_gb} GB RAM," \
                               " while current total RAM is #{current_ram_gb.round(2)}")
    end

    def check_hostname(hostname, extra_msg = '')
      return unless hostname == 'ubuntu'
      err_msg = "Error: hostname is #{hostname}. "\
                "Please check whether your hostname is properly configured.#{extra_msg}"
      Chef::Application.fatal!(err_msg)
    end

    def check_os_version(supported_os_list, current_os_version)
      supported_os_list.each do |os_version|
        return unless os_version != current_os_version
        Chef::Application.fatal!("Current OS version is #{current_os_version}. " \
                                 "Supported OS versions: #{supported_os_list.join(',')}")
      end
    end
  end

  ################################################################################
  # Network checks before update
  module HelperNetworkCheck
    def check_ip_reachable(ping_server_list)
      ping_server_list.each do |ping_server|
        ruby_block 'Check network connectivity' do
          block do
            Chef::Application.fatal!("ERROR: fail to ping #{ping_server}")
          end
          not_if "ping -c2 #{ping_server}"
        end
      end
    end

    def check_port_connect(ip_address, tcp_port)
      # TODO: to be implemented
    end

  end
end
