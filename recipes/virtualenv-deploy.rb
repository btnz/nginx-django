#
# Cookbook Name:: nginx-django
# Recipe:: virtualenv-deploy
#
# Copyright 2014, Keteparaha Ltd
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx-django::python-setup"


node[:deploy].each do | application, deploy|
  virtualenv_path = ::File.join(deploy[:deploy_to], "shared", "env")
  virtualenv_configure do
    deploy_data deploy
    app_name application
    virtualenv_path virtualenv_path
  end

  Chef::Log.debug("Installing virtualenv to : " + virtualenv_path)
  app_dir = ::File.join(deploy[:deploy_to], "current")
  requirements_file = "#{app_dir}/requirements.txt"
  if ::File.exists?(requirements_file)
    File.open(requirements_file) do | file_handle |
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
  else
    Chef::Log.debug(requirements_file + " not found, skipping virtualenv")
  end
end
