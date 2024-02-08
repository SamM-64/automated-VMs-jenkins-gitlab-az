#!/bin/bash

# Installer Certbot
sudo apt-get update
sudo apt-get install certbot -y

# Générer le certificat Let's Encrypt pour votre domaine
sudo certbot certonly --standalone -d votredomaine.com

# Configurer Jenkins pour utiliser le certificat
sudo sed -i 's|HTTP_PORT=8080|HTTP_PORT=-1|g' /etc/default/jenkins
sudo sed -i 's|JENKINS_HTTPS_KEYSTORE=.*|JENKINS_HTTPS_KEYSTORE="/etc/letsencrypt/live/votredomaine.com/fullchain.pem"|g' /etc/default/jenkins
sudo sed -i 's|JENKINS_HTTPS_KEYSTORE_PASSWORD=.*|JENKINS_HTTPS_KEYSTORE_PASSWORD="votre_mot_de_passe"|g' /etc/default/jenkins

# Redémarrer Jenkins
sudo systemctl restart jenkins
