# Encoding: utf-8
require 'serverspec'

# Required by serverspec
set :backend, :exec

%w(justniffer).each do |x|
  describe package(x) do
    it { should be_installed }
  end
end
