# -*- encoding: utf-8 -*-
#
# Cookbook Name:: backupdir
# Recipe:: default
#
# Copyright 2015, http://DennyZhang.com
#
# Apache License, Version 2.0
#
node.from_file(run_context.resolve_attribute('backupdir', 'default'))

['devops_backup_dir.sh', 'devops_backup_file.sh', \
 'random_sleep.sh', 'remote_copy_backupset.sh'].each do |x|
  cookbook_file "/usr/local/bin/#{x}" do
    source x
    mode '0755'
  end
end
