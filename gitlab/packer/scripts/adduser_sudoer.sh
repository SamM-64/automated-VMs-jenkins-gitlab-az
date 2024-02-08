#! /bin/sh
set -xe

export USER=admin

adduser --disabled-password --ingroup sudo --gecos "" $USER || echo "User $USER already exists"
echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER-user
mkdir -p /home/$USER/.ssh &&\
    touch /home/$USER/.ssh/authorized_keys &&\
    chmod 700 /home/$USER/.ssh &&\
    chmod 600 /home/$USER/.ssh/authorized_keys &&\
    chown -R $USER: /home/$USER/.ssh