define :python_base_setup do
  deploy = params[:deploy_data]
  application = params[:app_name]

  include_recipe "python::default"

  os_packages = deploy["os_packages"] ? deploy["os_packages"] : node["deploy_python"]["os_packages"]
    os_packages.each do |pkg,ver|
    package pkg do
      action :install
      version ver if ver && ver.length > 0
    end
  end

  directory "#{deploy[:deploy_to]}/shared" do
    group deploy[:group]
    owner deploy[:user]
    mode 0770
    action :create
    recursive true
  end

  virtualenv_path = ::File.join(deploy[:deploy_to], "shared", "env")
  python_virtualenv "#{application}-venv" do
     path virtualenv_path
     interpreter "python2.7"
     owner deploy[:user]
     group deploy[:group]
     action :create
  end

  packages = deploy["packages"] ? deploy["packages"] : node["deploy_python"]["packages"]
  packages.each do |name, ver|
    python_pip name do
      version ver if ver && ver.length > 0
      virtualenv virtualenv_path
      user deploy[:user]
      group deploy[:group]
      action :install
    end
  end

end
