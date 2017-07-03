# Encoding: utf-8

require 'serverspec'

# Required by serverspec
set :backend, :exec

#####################################################
# verify service running
describe port(4444) do
  it { should be_listening }
end

describe service('xvfb') do
  it { should be_running }
end

describe service('webdriver-manager') do
  it { should be_running }
end
