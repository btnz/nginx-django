name             'nginx-django'
maintainer       'Keteparaha Ltd'
maintainer_email 'bevan@keteparaha.co.uk'
license          'All rights reserved'
description      'Installs/Configures nginx-django'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "deploy"
depends "nginx"
depends "python"
depends "gunicorn"

recipe "deploy::app_deploy", "Deploy custom application"
