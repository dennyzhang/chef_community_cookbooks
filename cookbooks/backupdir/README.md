backupdir Cookbook
================
Backup directories by a crontab and do a remote copy

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
Critical data of prod envs usually reside in DB or conf files

After we have exported them to files and directories, we need backup them properly

This cookbook enables us to:

* Automate configure a daily cron to do the backup
* Directories will be copied to another local directories, and tar as a package with timestamp attached to the filename
* Do a remote copy for the latest tar file by scp or nfs everyday.
* To avoid local tar files take too much disk capacity, very old tar files will be deleted automatically.

Some files are so critical that we want to do a backup, whenever it changes:

* Setup a crontab which check the file every 5 min
* If the modified time of file is changed, do a backup with timestamp attached to the filename.
* If not changed, do nothing

- default
- backup-dir: Backup directories in the way explained in the info section
- backup-file: Backup critical files in the way explained in the info section

Attributes List
---------------

* `node['backupdir']['dir_list']` - Which directories to be backup
* `node['backupdir']['file_list']` - Which files to be closely monitored and backup
* `node['backupdir']['cron_time']` - When should be crontab been triggered. Default 01:05. If empty, skip crontab
* `node['backupdir'][remotecopy_method]` - How to do the remotecopy. Default is scp. If empty, skip remotecopy
* `node['backupdir'][remotecopy_parameter]` - Necessary parameters to do the remotecopy

Examples and Common usage
-------------------------
### Backup a directory without remote copy
```json
"backupdir": {
  "dir_list": "/data/neo4j;/var/mysql/exported/",
}
```

### Monitor changes to critical files and do the backup
```json
"backupdir": {
  "file_list": "/data/idm/keystore",
}
```

### Backup a directory with scp remote copy
```json
"backupdir": {
  "dir_list": "/data/neo4j;/var/mysql/exported/",
  "remotecopy_method": "scp"
  "remotecopy_parameter": "root@192.168.1.102:/shared/backup/"
}
```

License & Authors
-----------------
- Author:: DennyZhang <contact@dennyzhang.com>
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
