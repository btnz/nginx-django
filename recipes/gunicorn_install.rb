#
# Cookbook Name:: nginx-django
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:deploy].each do | application, deploy|

  init_file = "/etc/init.d/gunicorn_" + application
  template init_file do
    source "gunicorn_init.erb"
    mode 0755
    owner "root"
    group "root"
    variables({
      :app_name => application,
      :app_dir => deploy[:deploy_to]
    })
  end

  gunicorn_config deploy[:deploy_to] + "/gunicorn.py" do
    listen "unix:" + deploy[:deploy_to] + "/gunicorn.sock"
    worker_processes 8
    backlog 4096
    errorlog "/var/log/gunicorn_error"
    loglevel = "debug"
    owner deploy[:user]
    group deploy[:group]
    action :create
  end

  service "gunicorn_" + application do
    action [:enable, :start ]
  end
end

