# Encoding: utf-8
require 'serverspec'

# Required by serverspec
set :backend, :exec

################### verify service running ######################
describe service('nagios3'), :if => os[:family] == 'ubuntu' do
  it { should be_running }
end

describe service('nagios'), :if => os[:family] == 'redhat' do
  it { should be_running }
end

describe service('nagios-nrpe-server'), :if => os[:family] == 'ubuntu' do
  it { should be_running }
end

describe service('nrpe'), :if => os[:family] == 'redhat' do
  it { should be_running }
end
###################################################################

#################### verify http request ##########################
describe port(80) do
  it { should be_listening }
end

describe command('curl --noproxy 127.0.0.1 -I http://127.0.0.1/nagios 2>/dev/null | grep HTTP') do
  its(:stdout) { should match /HTTP\/1.1 401/ }
end
###################################################################

################### verify nagios nrpe check ######################
describe command('/usr/lib/nagios/plugins/check_nrpe -H 127.0.0.1 -c check_apache_log'), :if => os[:family] == 'ubuntu' do
  its(:stdout) { should match /OK - no errors or warnings/ }
end

describe command('/usr/lib64/nagios/plugins/check_nrpe -H 127.0.0.1 -c check_apache_log'), :if => os[:family] == 'redhat' do
  its(:stdout) { should match /OK - no errors or warnings/ }
end
###################################################################
