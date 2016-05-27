#
# Cookbook Name:: systempatch
# Recipe:: patch-cve-2014-0160
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
# patch the Heartbleed bug (CVE-2014-0160) in OpenSSL
package 'openssl' do
  action :upgrade
end
