# Encoding: utf-8
require 'serverspec'

# Required by serverspec
set :backend, :exec

#####################################################
# verify service running
describe port(4444) do
  it { should be_listening }
end

%w(xvfb webdriver-manager).each do |service|
  describe service(service) do
    it { should be_running }
  end
end
