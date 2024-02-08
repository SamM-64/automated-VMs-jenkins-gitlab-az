# Configuration d'une machine virtuelle personnalisée pour Gitlab et Jenkins

Ce document détaille les étapes nécessaires pour créer une machine virtuelle personnalisée dédiée aux serveurs Gitlab et Jenkins, ainsi que les processus d'installation et de configuration associés.

## Gitlab

### Création d'un principal de service Azure AD

Pour créer un principal de service, exécutez la commande suivante en remplaçant les valeurs nécessaires :

```bash
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/c56aea2c-50de-4adc-9673-6a8008892c21/resourceGroups/Samantha_M --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"
```

Notez les informations sensibles générées (client_id, client_secret et tenant_id) et stockez-les dans un fichier `secret.auto.pkvars.hcl`.

### Création de l'image personnalisée avec Packer

Personnalisez les variables selon vos besoins. Le script `setup.sh` permet de lancer les commandes de base pour l'installation et la configuration de Gitlab. 
Enfin, lancez la commande :

```bash
packer build .
``` 

## Infrastructure avec Terraform

Modifiez les variables du fichier `variables.tf`, ainsi que `source_address_prefix`  `admin-user` dans `terraform.tf` et définissez un `admin_password`.

Ensuite, exécutez les commandes suivantes :

```bash
terraform init
terraform plan
terraform apply 
``` 

Une fois l'infrastructure déployée, connectez-vous en SSH à la machine via :

```bash
ssh <you_admin_username<@<ip_public>
```

Lors de l'application, une clé SSH est créée dans le dossier `ssh_key`.

Vérifiez l'installation de Gitlab sur la machine avec :

```bash
sudo gitlab-ctl status
```

Si tous les services indiquent "ok-run", l'installation s'est bien déroulée et Gitlab est correctement configuré.

Accédez à l'interface de Gitlab via votre FQDN. 
![Connexion Gitlab](./static/img/gitlab1.png)


Pour vous connecter, utilisez l'utilisateur "root". Pour récupérer le mot de passe, accédez à `/etc/gitlab/initial-root-password`.
![Interface de Gitlab](./static/img/gitlab.png)


Si rien ne se passe lors de l'exécution de `sudo gitlab-ctl status`, reconfigurez l'installation en accédant à `/etc/gitlab/gitlab.rb`, modifiez l'URL externe avec votre FQDN et relancez l'installation avec :

```bash
sudo gitlab-ctl reconfigure
```

Redémarrez ensuite Gitlab avec :

```bash
sudo gitlab-ctl restart
```

## Jenkins

Il n'est pas nécessaire de recréer un principal de service. Il suffit de modifier les variables de Packer et de Terraform comme pour Gitlab. Une fois connecté en SSH à la machine, vérifiez le statut avec :

```bash
sudo systemctl status jenkins`
```

Le statut doit être "running".

Accédez à l'interface de Jenkins sur le port 8080.

![Interface de Jenkins](./static/img/jenkins1.png)

 Lors de la première connexion, récupérez le mot de passe dans `/var/jenkins/secrets/initialAdmin/Password`. Connectez-vous en tant que root pour y accéder (`sudo su`), puis copiez le mot de passe dans Jenkins et créez un utilisateur.


![Interface de Jenkins](./static/img/jenkins.png)




