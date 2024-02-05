#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt-get update
echo 'postfix postfix/main_mailer_type select Internet Site' | sudo debconf-set-selections
echo 'postfix postfix/mailname string example.com' | sudo debconf-set-selections
sudo apt-get install -y curl openssh-server ca-certificates postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo EXTERNAL_URL="http://gitlab.example.com" apt-get install gitlab-ce
