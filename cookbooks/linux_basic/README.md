linux_basic Cookbook
================
Basic common configuration for linux machines

Requirements
------------
### Platform
- Debian/Ubuntu
- RHEL/CentOS/Scientific
- Fedora
- ArchLinux
- FreeBSD

Recipes
-------
* default
Linux basic configure: install packages, improve security level, add OS users, enable coredump, change repo, etc.

* security
Apply system patch; Switch whether sshd allow password authentication; on-demand configure for iptables; etc

Usage
-----
Use the cookbook by `recipe[linux_basic]`.

Attributes List
---------------

* `node['basic']['readonly_user']` - If given, create an OS normal user accordingly. Otherwise skip
* `node['basic']['admin_user']` - If given, create an OS admin user accordingly. Otherwise skip
* `node['basic']['security']` - enforcing means apply security change, otherwise disable security setting

License & Authors
-----------------
- Author:: DennyZhang <denny@dennyzhang.com>
- Copyright:: 2015, http://DennyZhang.com

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
