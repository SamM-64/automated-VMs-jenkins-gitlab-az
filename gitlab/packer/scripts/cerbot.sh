#!/bin/bash

# Installer Certbot
sudo apt-get update
sudo apt-get install certbot -y

# Générer le certificat Let's Encrypt pour votre domaine
sudo certbot certonly --standalone -d vm-gitlab-ecf.westeurope.cloudapp.azure.com

# Configurer GitLab pour utiliser le certificat
sudo sed -i 's|external_url .*$|external_url "https://vm-gitlab-ecf.westeurope.cloudapp.azure.com"|g' /etc/gitlab/gitlab.rb
sudo sed -i '/^nginx\['"'"'ssl_certificate'"'"'\] .*/a\nginx['"'"'ssl_certificate_key'"'"'] = "/etc/letsencrypt/live/vm-gitlab-ecf.westeurope.cloudapp.azure.com/privkey.pem"' /etc/gitlab/gitlab.rb
sudo sed -i '/^nginx\['"'"'ssl_certificate'"'"'\] .*/a\nginx['"'"'ssl_certificate'"'"'] = "/etc/letsencrypt/live/vm-gitlab-ecf.westeurope.cloudapp.azure.com/fullchain.pem"' /etc/gitlab/gitlab.rb

# Reconfigurer GitLab
sudo gitlab-ctl reconfigure

