#
# Cookbook Name:: nginx-django
# Recipe:: gunicorn_start
#
# Copyright 2014, Bluecow Productions
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do | application, deploy|
  service "gunicorn_" + application do
    action [:enable, :start ]
  end
end


