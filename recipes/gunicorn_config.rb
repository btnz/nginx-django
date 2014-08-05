#
# Cookbook Name:: nginx-django
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do | application, deploy|
  gunicorn_config deploy[:deploy_to] + "/gunicorn.py" do
    bind "unix:" + deploy[:deploy_tp] + "/gunicorn.sock"
    worker_processes 8
    backlog 4096
    owner deploy[:user]
    group deploy[:group]
    action :create
  end
end

