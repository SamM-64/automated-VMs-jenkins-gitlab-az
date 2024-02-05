#!/bin/bash

# Charger les variables d'environnement depuis le fichier .env
export $(grep -v '^#' .env | xargs)

# Exécuter Packer avec les variables d'environnement et le fichier de variables
packer build -var-file=variables.pkr.hcl gitlab-azure.pkr.hcl

