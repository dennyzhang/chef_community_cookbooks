# Basic Intro
<a href="https://github.com/DennyZhang?tab=followers"><img align="right" width="200" height="183" src="https://www.dennyzhang.com/wp-content/uploads/denny/watermark/github.png" /></a>

[![Build Status](https://travis-ci.org/DennyZhang/cleanup_old_files.svg?branch=master)](https://travis-ci.org/DennyZhang/remote-commands-servers) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

[![LinkedIn](https://www.dennyzhang.com/wp-content/uploads/sns/linkedin.png)](https://www.linkedin.com/in/dennyzhang001) [![Twitter](https://www.dennyzhang.com/wp-content/uploads/sns/twitter.png)](https://twitter.com/dennyzhang001) [![Slack](https://www.dennyzhang.com/wp-content/uploads/sns/slack.png)](https://www.dennyzhang.com/slack) [![Github](https://www.dennyzhang.com/wp-content/uploads/sns/github.png)](https://github.com/DennyZhang)

File me [tickets](https://github.com/DennyZhang/cleanup_old_files/issues) or star [the repo](https://github.com/DennyZhang/cleanup_old_files).

Clean up old files or folders

# How To Use
```
Denny:dennyzhang.com denny$ ./cleanup_old_files.py  --help
usage: cleanup_old_files.py [-h] --working_dir WORKING_DIR [--examine_only] [--filename_pattern FILENAME_PATTERN]
                            [--cleanup_type CLEANUP_TYPE] [--min_copies MIN_COPIES] [--min_size_kb MIN_SIZE_KB]

optional arguments:
  -h, --help            show this help message and exit
  --working_dir WORKING_DIR
                        Perform cleanup under which directory
  --examine_only        Only list delete candidates, instead perform the actual removal
  --filename_pattern FILENAME_PATTERN
                        Filter files/directories by filename, before cleanup
  --cleanup_type CLEANUP_TYPE
                        Whether to perform the cleanup for files or directories
  --min_copies MIN_COPIES
                        minimal copies to keep, before removal.
  --min_size_kb MIN_SIZE_KB
                        When remove files, skip files too small. It will be skipped when removing directories
```

# License
- Code is licensed under [MIT License](https://www.dennyzhang.com/wp-content/mit_license.txt).

<img align="right" width="200" height="183" src="https://www.dennyzhang.com/wp-content/uploads/gif/magic.gif">
