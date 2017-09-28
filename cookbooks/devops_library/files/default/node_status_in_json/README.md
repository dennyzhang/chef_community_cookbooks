# Basic Intro
<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://www.dennyzhang.com/wp-content/uploads/denny/watermark/github.png" /></a>

[![Build Status](https://travis-ci.org/DennyZhang/node_status_in_json.svg?branch=master)](https://travis-ci.org/DennyZhang/remote-commands-servers) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://www.dennyzhang.com/wp-content/uploads/sns/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) [![Twitter](https://www.dennyzhang.com/wp-content/uploads/sns/twitter.png)](https://twitter.com/dennyzhang001) [![Slack](https://www.dennyzhang.com/wp-content/uploads/sns/slack.png)](https://goo.gl/ozDDyL) [![Github](https://www.dennyzhang.com/wp-content/uploads/sns/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/node_status_in_json/issues) or star [the repo](https://github.com/DennyZhang/node_status_in_json).

Read more: https://www.dennyzhang.com/chatqueryhost

# How To Use
```
# Get the code
git clone https://github.com/DennyZhang/node_status_in_json.git
cd node_status_in_json
pip install -r requirements.txt
```

```
# Query node usage with everything default
python ./node_usage.py

# Query node usage and show service status
python ./node_usage.py --check_service_command "service elasticsearch status"

# Query node usage and tail one log file
python ./node_usage.py --log_file "/var/log/elasticsearch/mycluster.log"
```

# Console Output
```
Denny:dennyzhang.com denny$ python ./node_usage.py
{"hostname": "chat.dennyzhang.com", "cpu_count": 8, "ram": {"used_percentage": "13.64%(3.21gb/23.54gb)", "ram_buffers_gb": "2.00", "ram_available_gb": "19.75", "ram_total_gb": "23.54", "ram_used_gb": "3.21"}, "ipaddress_eth0": "45.33.87.74", "disk": {"free_gb": "493.96", "used_gb": "223.91", "disk_0": {"free_gb": "246.98", "total_gb": "378.14", "partition": "/", "used_percentage": "29.61%", "used_gb": "111.95"}, "disk_1": {"free_gb": "246.98", "total_gb": "378.14", "partition": "/var/lib/docker/overlay", "used_percentage": "29.61%", "used_gb": "111.95"}, "total_gb": "756.28", "used_percentage": "/ 29.61%(111.95gb/378.14gb), /var/lib/docker/overlay 29.61%(111.95gb/378.14gb)"}, "cpu_load": "0.00 0.00 0.00 1/707 15453"}
```

# Online Usage
```
Denny:dennyzhang.com denny$ ./node_usage.py --help
usage: node_usage.py [-h] [--check_service_command CHECK_SERVICE_COMMAND] [--log_file LOG_FILE] [--tail_log_num TAIL_LOG_NUM]

optional arguments:
  -h, --help            show this help message and exit
  --check_service_command CHECK_SERVICE_COMMAND
                        What command to check service status. If not given, service check will be skipped
  --log_file LOG_FILE   Tail log file
  --tail_log_num TAIL_LOG_NUM
                        Tail last multiple lines of log file
```

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).

<img align="right" width="200" height="183" src="https://www.dennyzhang.com/wp-content/uploads/gif/magic.gif">
