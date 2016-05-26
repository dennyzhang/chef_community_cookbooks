# -*- encoding: utf-8 -*-
# Working directory for generated report and chef handler
default['chef_changereport_handler']['working_dir'] = '/root/chef_update'
# Extra info you can specify which will be combined into report
default['chef_changereport_handler']['report_extra_info'] = ''
# Bash command you want to run, after deployment failure
default['chef_changereport_handler']['command_run_after_failure'] = ''
