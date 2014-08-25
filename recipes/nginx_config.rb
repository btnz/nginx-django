#
# Cookbook Name:: nginx-django
# Recipe:: nginx_config
#
# Copyright 2014, Bluecow Productions
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx::default"

file "#{node[:nginx][:dir]}/sites-enabled/default" do
  action :delete
  only_if do
    File.exists?("#{node[:nginx][:dir]}/sites-enabled/default")
  end
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
