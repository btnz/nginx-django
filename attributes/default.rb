include_attribute "deploy"
#include_attribute "opsworks_deploy_python::django"
#include_attribute "opsworks_deploy_python::buildout"

node.default["deploy_python"]["custom_type"] = "python"
node.default["deploy_python"]["symlink_before_migrate"] = {}
node.default["deploy_python"]["purge_before_symlink"] = []
node.default["deploy_python"]["create_dirs_before_symlink"] = ['public', 'tmp']
node.default["deploy_python"]["packages"] = ['Django']
node.default["deploy_python"]["os_packages"] = ["libpq-dev", "python-dev"]
node.default["deploy_python"]["venv_options"] = '--no-site-packages'

default["deploy_django"] = {}
default["deploy_django"]["database"] = {}
default["deploy_django"]["database"]["adapter"] = nil
default["deploy_django"]["database"]["name"] = nil
default["deploy_django"]["database"]["username"] = nil
default["deploy_django"]["database"]["password"] = nil
default["deploy_django"]["settings"] = {}

