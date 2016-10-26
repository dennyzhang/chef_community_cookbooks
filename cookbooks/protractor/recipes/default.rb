# -*- encoding: utf-8 -*-
#
# Cookbook Name:: protractor
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
include_recipe 'apt::default'
#############################################
node.default['java']['install_flavor'] = 'oracle'
node.default['java']['jdk_version'] = '8'
node.default['java']['oracle']['accept_oracle_download_terms'] = true
node.default['java']['oracle_rpm']['type'] = 'jdk'
node.default['java']['oracle']['jce']['enabled'] = true

# Download from original oracle is way too slow, and tend to timeout
# Original Oracle JDK download link
# http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
# http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-x64.tar.gz
# Cache jdk file of Oracle
node.default['java']['jdk']['8']['x86_64']['url'] = node['protractor']['jdk_url']

# shasum -a 256 ./jdk-8u40-linux-x64.tar.gz
node.default['java']['jdk']['8']['x86_64']['checksum'] = \
  'da1ad819ce7b7ec528264f831d88afaa5db34b7955e45422a7e380b1ead6b04d'

include_recipe 'java'

# symbol link /usr/bin/java
link '/usr/bin/java' do
  to '/usr/lib/jvm/java-8-oracle-amd64/bin/java'
end

#############################################
# xvfb
%w(libxi6 libgconf-2-4 imagemagick xfonts-100dpi lsof).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

%w(xfonts-75dpi xfonts-scalable xfonts-cyrillic xvfb x11-apps).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

file '/etc/profile.d/xvfb.sh' do
  mode 0o544
  action :create
  content "XVFB_PORT=#{node['protractor']['xvfb_port']}"
end

template '/etc/init.d/xvfb' do
  source 'xvfb.initscript'
  owner 'root'
  group 'root'
  mode 0o755
end

service 'xvfb' do
  supports status: true
  action [:enable, :start]
end

#############################################
%w(chromium-browser).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

#############################################
# Install nodejs and npm packages
node.default['nodejs']['install_method'] = 'source'
node.default['nodejs']['engine'] = 'node'
node.default['nodejs']['version'] = '0.12.1'

node.default['nodejs']['source']['url'] = node['protractor']['nodejs_url']

node.default['nodejs']['source']['checksum'] = \
  '270d478d0ffb06063f01eab932f672b788f6ecf3c117075ac8b87c0c17e0c9de'

node.default['nodejs']['npm']['install_method'] = 'source'

ark 'nodejs-source' do
  url node['nodejs']['source']['url']
  version node['nodejs']['version']
  checksum node['nodejs']['source']['checksum']
  action :install
end

link '/usr/bin/node' do
  to "/usr/local/nodejs-source-#{node['nodejs']['version']}/bin/node"
end

link '/usr/bin/npm' do
  to "/usr/local/nodejs-source-#{node['nodejs']['version']}/bin/npm"
end

include_recipe 'nodejs::npm_from_source'
include_recipe 'nodejs::default'

#############################################
# enable protractor
nodejs_npm 'protractor'
execute 'webdriver-manager update' do
  command 'webdriver-manager update'
  action :run
  not_if 'webdriver-manager status  | grep \"chromedriver is up to date\"'
end

#############################################
template '/etc/init.d/webdriver-manager' do
  source 'webdriver-manager.initscript'
  owner 'root'
  group 'root'
  mode 0o755
  notifies :restart, 'service[webdriver-manager]', :delayed
end

service 'webdriver-manager' do
  supports status: true
  action [:enable, :start]
end
#############################################

# Test protractor GUI login
directory node['protractor']['test_dir'] do
  owner 'root'
  group 'root'
  mode 0o755
  action :create
end

%w(conf.js test.js).each do |x|
  cookbook_file "#{node['protractor']['test_dir']}/#{x}" do
    source x
    mode '0755'
  end
end
