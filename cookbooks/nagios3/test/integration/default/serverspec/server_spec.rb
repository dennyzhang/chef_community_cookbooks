# Encoding: utf-8

require 'serverspec'

# Required by serverspec
set :backend, :exec

check_nrpe = '/usr/lib/nagios/plugins/check_nrpe'
################### verify service running ######################
if os[:family] == 'ubuntu'
  describe service('nagios3') do
    it { should be_running }
  end

  describe service('nagios-nrpe-server') do
    it { should be_running }
  end
end

if os[:family] == 'redhat'
  describe service('nagios') do
    it { should be_running }
  end

  describe service('nrpe') do
    it { should be_running }
  end

  check_nrpe = '/usr/lib64/nagios/plugins/check_nrpe'
end
###################################################################

#################### verify http request ##########################
describe port(80) do
  it { should be_listening }
end

describe command('curl -I http://127.0.0.1/nagios 2>/dev/null | grep HTTP') do
  its(:stdout) { should contain 'HTTP/1.1 401' }
end
###################################################################

################### verify nagios nrpe check ######################
describe command("#{check_nrpe} -H 127.0.0.1 -c check_apache_log") do
  its(:stdout) { should contain 'OK - no errors or warnings' }
end
###################################################################
