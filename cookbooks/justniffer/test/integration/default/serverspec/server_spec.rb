# Encoding: utf-8
require 'serverspec'

# Required by serverspec
set :backend, :exec

%w(justniffer).each do |x|
  describe package(x) do
    it { should be_installed }
  end
end

describe command('pgrep justniffer') do
  its(:exit_status) { should eq 0 }
end

describe file('/root/justniffer.log') do
  it { should be_file }
end
