#
# Cookbook Name:: systempatch
# Recipe:: patch-cve-2014-6271
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
# Shellshock (Bash CVE-2014-6271)
check_bash_vulnerable = "bash -c 'echo this is a test' | grep vulnerable"

case node['platform_family']
when 'debian'
  # install packages for debian
  # upgrade bash for security issue of CVE-2014-6271
  apt_package 'bash' do
    action :upgrade
    only_if "env x='() { :;}; echo vulnerable' #{check_bash_vulnerable}"
  end
when 'fedora', 'rhel', 'suse'
  %w(redhat-lsb).each do |x|
    package x do
      action :install
    end
  end

  # upgrade bash for security issue of CVE-2014-6271
  yum_package 'bash' do
    action :upgrade
    only_if "env x='() { :;}; echo vulnerable' #{check_bash_vulnerable}"
  end

else
  Chef::Application.fatal!('Need to customize for OS of #{node[:platform_family]}')
end
