name             'skylab'
maintainer       'Kunstmaan'
maintainer_email 'support@kunstmaan.be'
license          'MIT'
description      'Installs a server or development machine to run the Skylab hosting platform.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

supports         'ubuntu'
supports         'mac_os_x'

depends          'applications'
depends          'dotfiles'
depends          'git'
