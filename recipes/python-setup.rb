#
# Cookbook Name:: nginx-django
# Recipe:: python-setup
#
# Copyright 2014, Keteparaha Ltd
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do | application, deploy|
#   if deploy["custom_type"] != 'python'
#      next
#   end

   python_base_setup do
      deploy_data deploy
      app_name application
   end
end
