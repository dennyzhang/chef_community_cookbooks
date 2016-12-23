module PreCheck
  # Precheck for input parameters and infrastructure layer
  module HelperInputFormat
    # Parmaeter checks for input format

    def check_ip_format(ip_address, extra_msg = '')
      block = /\d{,2}|1\d{2}|2[0-4]\d|25[0-5]/
      re = /\A#{block}\.#{block}\.#{block}\.#{block}\z/

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

    def check_tcp_port_format(ip_address)
      # TODO: to be implemented
    end

    def check_int_format(ip_address)
      # TODO: to be implemented
    end
  end

  # Infra checks before update
  module HelperInfraCheck
    def check_capcity_disk(ip_address)
      # TODO: to be implemented
    end

    def check_capacity_cpu(ip_address)
      # TODO: to be implemented
    end

    def check_capacity_mem(ip_address)
      # TODO: to be implemented
    end

    def check_os_version(ip_address)
      # TODO: to be implemented
    end

    def check_ip_reachable(ip_address)
      # TODO: to be implemented
    end

    def check_hostname(hostname, extra_msg = '')
      return unless hostname != 'ubuntu'
      err_msg = "Error: hostname is #{hostname}. "\
                "Please check whether your hostname is properly configured.#{extra_msg}"
      Chef::Application.fatal!(err_msg)
    end
  end
end
