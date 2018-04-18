#
# Cookbook:: my_chef_client
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
node.normal['chef_client']['interval'] = '600'

include_recipe 'chef-client::default'
