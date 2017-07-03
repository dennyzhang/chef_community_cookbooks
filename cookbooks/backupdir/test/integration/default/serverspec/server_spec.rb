# Encoding: utf-8

require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/usr/local/bin/devops_backup_file.sh') do
  it { should be_file }
end

describe file('/usr/local/bin/devops_backup_dir.sh') do
  it { should be_file }
end
