name 'linux_basic'
maintainer 'DennyZhang.com'
maintainer_email 'denny@dennyzhang.com'
license 'All rights reserved'
description 'Basic DevOps for single machine'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.3.3'
issues_url 'https://www.dennyzhang.com'
source_url 'https://www.dennyzhang.com'

supports 'ubuntu', '>= 12.04'
supports 'debian', '>= 6.0'
supports 'centos', '>= 6.5'

depends 'ntp'
depends 'timezone-ii'
depends 'openssh'
depends 'selinux'

depends 'apt'
depends 'yum-epel'
