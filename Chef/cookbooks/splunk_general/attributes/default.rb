default['splunk']['install']['root'] = '/opt'
default['splunk']['install']['home'] = "#{node['splunk']['install']['root']}/splunk"
default['splunk']['install']['cmd'] = "#{node['splunk']['install']['home']}/bin/splunk"

default['splunk']['data']['root'] = '/var'
default['splunk']['data']['home'] = "#{node['splunk']['data']['root']}/splunk"
default['splunk']['data']['hot'] = "#{node['splunk']['data']['home']}/hotwarm"
default['splunk']['data']['warm'] = "#{node['splunk']['data']['home']}/hotwarm"
default['splunk']['data']['cold'] = "#{node['splunk']['data']['home']}/cold"

default['splunk']['version'] = '7.0.1'
default['splunk']['hash'] = '2b5b15c4ee89'

default['splunk']['deploymentserver']['ip'] = ''
