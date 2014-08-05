#
# Cookbook Name:: nginx-django
# Recipe:: nginx_config
#
# Copyright 2014, Bluecow Productions
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do | application, deploy|
   template "/etc/nginx/sites-enabled/default" do
      source "default-site.erb"
      owner "root"
      group "root"
      mode 0644
      variables({
        :deploy_data => deploy,
        :application => application
      })
   end
end
