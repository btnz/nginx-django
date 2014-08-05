#
# Cookbook Name:: nginx-django
# Recipe:: virtualenv-deploy
#
# Copyright 2014, Keteparaha Ltd
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"

node[:deploy].each do | application, deploy|
  virtualenv_path = node[:virtualenv_path]
  app_dir = ::File.join(deploy[:deploy_to], "current", application)
  File.open("#{app_dir}/requirements.txt") do | file_handle |
    file_handle.each_line do | line |
      package, ver = line.split("==")
      python_pip package do
        version ver if ver && ver.length > 0
        virtualenv virtualenv_path
        user deploy[:user]
        group deploy[:group]
        action :install
      end
    end
  end
end
