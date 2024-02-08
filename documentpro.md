# Livrables:

## Routine : Automatisation des mises à jour des templates avec Azure DevOps


Pour automatiser les mises à jour des templates de machines virtuelles, l'équipe des administrateurs Cloud de Prodigy Software a choisi d'utiliser Azure DevOps. Voici les étapes clés de leur solution :


### 1. Configuration de l'environnement Azure DevOps :

- Création d'un projet Azure DevOps dédié à la gestion des templates de machines virtuelles.

- Configuration des pipelines CI/CD pour les serveurs GitLab et Jenkins.

### 2. Intégration des fichiers de déploiement Packer :

- Importation des fichiers de déploiement Packer pour les serveurs GitLab et Jenkins dans le référentiel Azure DevOps.

### 3. Configuration des pipelines CI/CD :

- Création de pipelines CI/CD pour chaque template de machine virtuelle.

- Définition des étapes de pipeline pour la création, la validation et la publication des nouvelles versions des templates.

### 4. Planification des mises à jour :

- Planification des horaires de mise à jour pour minimiser les perturbations potentielles dans les environnements de production.

- Utilisation des déclencheurs de pipeline pour déclencher automatiquement les mises à jour selon un calendrier défini.

### 5. Tests et validation :

- Intégration de tests automatisés dans les pipelines CI/CD pour vérifier la stabilité et la performance des nouveaux templates.

- Validation manuelle des nouvelles versions des templates avant leur déploiement dans les environnements de production.

**Résultats attendus :**

En mettant en œuvre cette routine de mise à jour automatisée avec Azure DevOps, Prodigy Software pourra garantir la sécurité et la fiabilité de ses environnements cloud. Les templates de machines virtuelles utilisés pour les serveurs GitLab et Jenkins seront régulièrement mis à jour pour inclure les derniers correctifs de sécurité et les améliorations logicielles, contribuant ainsi à optimiser les opérations de développement et de déploiement de l'entreprise.


# Dossier Preuve Professionnelle

## Rappel du Contexte :

La société Prodigy Software est confrontée à une croissance rapide de son activité et doit déployer ses solutions logicielles dans un nombre croissant d'environnements clients. Pour relever ce défi, l'entreprise cherche à automatiser le déploiement de ses solutions sur des machines virtuelles dans le cloud.

**Sommaire :**

1. Qu'est-ce qu'un template ?
2. Principales étapes pour réaliser un template sur Azure.
3. Qu'est-ce qu'un déploiement ?
4. Principales étapes pour réaliser un déploiement sur Azure.
5. Qu'est-ce qu'une routine ?
6. Principales étapes pour réaliser une routine de mise à jour.


### **Réponses aux Questions :**
**1. Qu'est-ce qu'un template ?**
- Un template est un modèle préconfiguré qui définit la configuration de base d'une ressource, telle qu'une machine virtuelle, dans un environnement cloud. Il permet de créer des instances de ressources cohérentes et reproductibles en automatisant la configuration initiale.

**2. Principales étapes pour réaliser un template sur Azure :**

- Configuration initiale de la machine virtuelle avec les logiciels et paramètres nécessaires.
- Capture de l'image de la machine virtuelle pour en faire un template.
- Publication et gestion du template dans Azure.

**3. Qu'est-ce qu'un déploiement ?**
- Un déploiement fait référence à la mise en place et à la configuration de ressources informatiques, telles que des machines virtuelles, des applications, ou des services, dans un environnement cible.

**4. Principales étapes pour réaliser un déploiement sur Azure :**

- Sélection des ressources à déployer.
- Configuration des paramètres et des options de déploiement.
- Validation et exécution du déploiement.

**5. Qu'est-ce qu'une routine ?**
- Une routine est une série d'actions planifiées et répétitives visant à automatiser des processus spécifiques, tels que la maintenance ou la mise à jour de logiciels et d'infrastructures informatiques.

**6. Principales étapes pour réaliser une routine de mise à jour :**
- Identification des composants à mettre à jour.
- Planification des périodes de maintenance.
- Automatisation des processus de mise à jour à l'aide d'outils et de scripts appropriés.