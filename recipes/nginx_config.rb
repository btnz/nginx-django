#
# Cookbook Name:: nginx-django
# Recipe:: nginx_config
#
# Copyright 2014, Bluecow Productions
#
# All rights reserved - Do Not Redistribute
#

#include_recipe "nginx::default"

package "nginx" do
  action :install
end

nginx_site 'default' do
  enable false
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

node[:deploy].each do | application, deploy|
   template "/etc/nginx/sites-available/api.bluecow" do
      source "api-bluecow.erb"
      owner "root"
      group "root"
      mode 0644
      variables({
        :deploy_data => deploy,
        :application => application
      })
      notifies :reload, "service[nginx]"
   end
end
