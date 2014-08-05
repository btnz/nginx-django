#
# Cookbook Name:: nginx-django
# Recipe:: app_deploy
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'deploy'

node[:deploy].each do | application, deploy|
  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  app_configure do
    deploy_data deploy
    app application
  end

  virtualenv_setup do
    deploy_data deploy
    app application
  end
end

