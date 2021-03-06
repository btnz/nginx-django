define :app_configure do
  deploy = params[:deploy_data]
  application = params[:app]
  run_action = params[:run_action] || :restart

  deploy = node[:deploy][application]

  if deploy[:deploy_to] && (node[:deploy][application]["initially_deployed"] || ::File.exist?(deploy[:deploy_to]))
    django_settings = ::File.join(deploy[:deploy_to], 'current', application, 'settings.py')
    template django_settings do
      source "settings.py.erb"
      owner deploy[:user]
      group deploy[:group]
      mode 0660
      variables Hash.new
      variables.update deploy
      variables.update :django_database => node[:deploy][application]["database"] || node["deploy_django"]["database"]
      variables.update :django_settings => node[:deploy][application]["django_settings"] || node["deploy_django"]["settings"]
      variables.update :social_auth => node[:deploy][application]["social_auth"] || node["social_auth"]
    end
  end
end

define :virtualenv_setup do
  deploy = params[:deploy_data]
  application = params[:app]

  deploy = node[:deploy][application]

  virtualenv_path = ::File.join(deploy[:deploy_to], "shared", "env")
  requirements_file = ::File.join(deploy[:deploy_to], "current", "requirements.txt")
  if ::File.exists?(requirements_file)
    File.open(requirements_file) do | file_handle |
      file_handle.each_line do | line |
        package, ver = line.split("==")
        python_pip package do
          version ver if ver && ver.length > 0
          Chef::Log.debug("Installing to: " + node["python"]["virtualenv_location"])
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

define :collect_static do
  deploy = params[:deploy_data]
  application = params[:app]
  virtualenv_path = params[:virtualenv]
  
  execute "#{::File.join(virtualenv_path, "bin", "python")} manage.py collectstatic --noinput" do
    user deploy[:user]
    group deploy[:group]
    cwd ::File.join(deploy[:deploy_to], "current")
  end
end
    
define :south_migration do
  deploy = params[:deploy_data]
  application = params[:app]

  deploy = node[:deploy][application]
end
