name 'splunk_general'
maintainer 'ndewijer'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures splunk-general'
long_description 'Installs/Configures splunk-general'
version '0.1.3'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'filesystem'
depends 'ohai'
depends 'tar'
