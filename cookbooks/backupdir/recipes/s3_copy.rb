# -*- encoding: utf-8 -*-
#
# Cookbook Name:: backupdir
# Recipe:: s3_copy
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#

# # #####################################################
%w(python-pip).each do |x|
  package x do
    action :install
    not_if "dpkg -l #{x} | grep -E '^ii'"
  end
end

python_pip 'awscli' do
  action :install
  only_if "pip search awscli | grep '^Name: '"
end

directory '/root/.aws' do
  owner 'root'
  group 'root'
  mode 00700
  action :create
end

%w(config credentials).each do |x|
  template "/root/.aws/#{x}" do
    source "aws_#{x}.erb"
    mode '0600'
  end
end

# https://github.com/DennyZhang/S3Sync
remote_file '/opt/mdm/bin/s3sync.sh' do
  source 'https://raw.githubusercontent.com/DennyZhang/S3Sync/master/s3sync.sh'
  mode '0755'
  retries 3
  retry_delay 3
end

# TODO: s3sync.sh backup /data/backup/archive denny-bucket2
#        s3backup/dir1 /opt/dir1/config/s3.metadata
# # #####################################################
