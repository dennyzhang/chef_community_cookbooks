# Encoding: utf-8

require 'serverspec'

# Required by serverspec
set :backend, :exec

%w(/opt/devops/bin/enforce_all_nagios_check.sh
   /opt/devops/bin/wait_for.sh).each do |x|
  describe file(x) do
    it { should be_file }
  end
end

%w(lsof curl tmux).each do |x|
  describe package(x) do
    it { should be_installed }
  end
end
