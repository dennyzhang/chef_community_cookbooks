chef_changereport_handler Cookbook
================
Generate chef report after deploy: change list, update summary, etc.

Requirements
------------
### Platform
- Debian/Ubuntu

Recipes
-------
* default
Enable Chef handler: report what are changed by chef and record update summary to disk

Usage
-----
Use the cookbook by `recipe[chef_changereport_handler]`.

Attributes List
---------------
* `node['chef_changereport_handler']['working_dir']` - Working directory for generated report and chef handler
* `node['chef_changereport_handler']['report_extra_info']` - Extra info you can specify which will be combined into report
* `node['chef_changereport_handler']['command_run_after_failure']` - Bash command you want to run, after deployment failure

Examples and Common usage
-------------------------
#### When deployment failed, run customized command
```json
"chef_changereport_handler": {
  "command_run_after_failure": "echo failed >> /tmp/test.log"
}
```
Sample output for the report
-----------------
The handler outputs to log after Chef Run follwing.

```
========================================================
Chef Update Run On: chef_changereport_handler-DeployChefCookbooks-114-anonymous
Started: 2016-04-10 00:50:07, Ended: 2016-04-10 00:50:07, duration: 0.09s
Update Status: success
Changed List: 2 resources are changed
    - template[/root/chef_update/handlers/changereport_handler.rb]
    - chef_handler[MyChefReport::ChangReportHandler]
Detail info:
    My extra info message
```

License & Authors
-----------------
- Author:: DennyZhang001 <denny@dennyzhang.com>
- Copyright:: 2016, http://DennyZhang.com

```text

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
