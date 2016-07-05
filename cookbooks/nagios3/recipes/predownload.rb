#
# Cookbook Name:: nagios3
# Recipe:: predownload
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

# nagios
%w(tar bc libwww-perl libcrypt-ssleay-perl nagios3 nagios-nrpe-plugin librrds-perl
   libgd-gd2-perl net-tools nagios-nrpe-server nagios-plugins nagios-plugins-basic
   libsys-statistics-linux-perl).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end
