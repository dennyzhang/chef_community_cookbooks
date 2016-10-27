# Encoding: utf-8
require 'serverspec'

# Required by serverspec
set :backend, :exec

def run_check_jenkins_job(jenkins_run_cmd, jenkins_check_cmd, \
                          job_name, parameters)
  # Run jenkins jobs once and verify the job status
  describe command("#{jenkins_run_cmd} #{job_name} -w #{parameters}") do
    its(:stdout) { should contain 'Started ' }
    its(:exit_status) { should eq 0 }
  end

  describe command("#{jenkins_check_cmd} #{job_name}") do
    its(:stdout) { should contain 'Jenkins job success: ' }
    its(:exit_status) { should eq 0 }
  end
end
