module PreCheck
  module HelperInputFormat
    # Parmaeter checks for input format

    def check_ip_format(ip_address)
      # TODO:
      return true
    end

    def check_tcp_port_format(ip_address)
      # TODO:
      return true
    end

    def check_int_format(ip_address)
      # TODO:
      return true
    end

    def check_ip_list_format(ip_address)
      # TODO:
      return true
    end

  end

  module HelperInfraCheck
    # Infra checks before update

    def check_capcity_disk(ip_address)
      # TODO:
      return true
    end

    def check_capacity_cpu(ip_address)
      # TODO:
      return true
    end

    def check_capacity_mem(ip_address)
      # TODO:
      return true
    end

    def check_os_version(ip_address)
      # TODO:
      return true
    end

    def check_ip_reachable(ip_address)
      # TODO:
      return true
    end

    def check_hostname(hostname, extra_msg = '')
      if hostname == 'ubuntu'
        err_msg = "Error: hostname is #{hostname}. "\
                  "Please check whether your hostname is properly configured.#{extra_msg}"
        Chef::Application.fatal!(err_msg)
      end
    end
  end
end
