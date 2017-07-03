# -*- encoding: utf-8 -*-

default['general_security']['ssh_disable_passwd_login'] = 'true'
default['general_security']['ssh_disable_root_login'] = 'false'

# sshd use secured ciphers stream: configure to empty, if you want to skip this change
default['general_security']['ssh_ciphers_stream'] = \
  'aes256-ctr,aes192-ctr,aes128-ctr'

# sshd use secured MACs algorithms: configure to empty, if you want to skip this change
default['general_security']['ssh_macs_algorithms'] = 'hmac-sha1'
