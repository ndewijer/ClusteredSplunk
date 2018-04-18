#
# Cookbook:: splunk-general
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

download_url = "https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=#{node['splunk']['version']}&product=splunk&filename=splunk-#{node['splunk']['version']}-#{node['splunk']['hash']}-Linux-x86_64.tgz&wget=true"

if platform?('amazon')
  filesystem 'splunk_home' do
    fstype 'ext4'
    device '/dev/xvdf'
    mount "#{node['splunk']['install']['home']}"
    action [:create, :enable, :mount]
  end

  filesystem 'splunk_data_warm' do
    fstype 'ext4'
    device '/dev/xvdg'
    mount "#{node['splunk']['data']['warm']}"
    action [:create, :enable, :mount]
  end

  filesystem 'splunk_data_cold' do
    fstype 'ext4'
    device '/dev/xvdh'
    mount "#{node['splunk']['data']['cold']}"
    action [:create, :enable, :mount]
  end

  tar_extract download_url do
    #target_dir node['splunk']['install']['root'].to_s
    target_dir '/opt/splunk'
    #creates "#{node['splunk']['install']['home']}"
  end

  execute 'enable splunk boot' do
    command "sudo #{node['splunk']['install']['cmd']} enable boot-start --accept-license"
    action :run
  end

  execute 'enable splunk start' do
    command "sudo #{node['splunk']['install']['cmd']} start"
    action :run
  end

end
