# Guide d'Administration du Site - UniGames

**Date :** 3 Juin 2026
**Projet :** UniGames

Ce manuel technique est destiné aux administrateurs système et aux développeurs chargés du déploiement et de la maintenance de la plateforme UniGames.

## 1. Stack Technique

- **Framework :** Symfony 7.x
- **Langage :** PHP 8.x
- **ORM :** Doctrine
- **Moteur de templates :** Twig
- **Base de données :** MySQL / MariaDB
- **Serveur web :** Apache ou Nginx (ou Symfony CLI en environnement de développement)
- **Gestionnaire de paquets :** Composer

## 2. Structure du Projet

```text
src/
├── Controller/         # 11 contrôleurs gérant les routes
├── Entity/             # 7 entités Doctrine modélisant la BDD
├── EventSubscriber/    # Écouteurs globaux (ex: ContextSubscriber)
├── Form/               # 6 types de formulaires
├── Repository/         # Requêtes base de données personnalisées
└── DataFixtures/       # (Optionnel) Données factices pour les tests
templates/              # 10 sous-dossiers de vues + base.html.twig
migrations/             # Fichiers de migration de schéma BDD
config/                 # Fichiers de configuration (YAML)
public/                 # Point d'entrée (index.php), CSS, JS, images
```

## 3. Déploiement et Installation

### 3.1 Prérequis
- PHP 8.1 ou supérieur (avec extensions pdo_mysql, intl, mbstring)
- Composer installé globalement
- Serveur MySQL/MariaDB en cours d'exécution

### 3.2 Étapes d'installation
1. **Cloner le projet :**
   ```bash
   git clone <url-du-depot> unigames
   cd unigames
   ```
2. **Installer les dépendances :**
   ```bash
   composer install
   ```
3. **Configurer l'environnement :**
   Créez un fichier `.env.local` à la racine (ou modifiez le `.env`) et configurez l'accès à la base de données :
   ```env
   DATABASE_URL="mysql://utilisateur:motdepasse@127.0.0.1:3306/unigames?serverVersion=8.0"
   APP_ENV=prod  # (ou dev)
   APP_SECRET=VotreCleSecreteIci
   ```
4. **Créer la base de données et appliquer le schéma :**
   ```bash
   php bin/console doctrine:database:create
   php bin/console doctrine:migrations:migrate
   ```
5. **(Optionnel) Charger les données de test :**
   ```bash
   php bin/console doctrine:fixtures:load
   ```
6. **Lancer le serveur (Environnement de Dev) :**
   ```bash
   symfony server:start
   ```

## 4. Gestion des Utilisateurs et Sécurité

### 4.1 Rôles
La sécurité repose sur la hiérarchie classique de Symfony définie dans `config/packages/security.yaml`.
- `ROLE_ADMIN` : Super-administrateur.
- `ROLE_STAFF` : Responsable sportif.
- `ROLE_VIEWER` : Simple lecteur.

### 4.2 Administration des comptes
En tant que `ROLE_ADMIN`, rendez-vous sur l'URL `/admin/users`.
Vous pourrez y lister, créer, modifier ou supprimer des comptes. Les mots de passe sont automatiquement hachés avec le service natif `UserPasswordHasherInterface` (algorithme `bcrypt` ou `argon2i`).

## 5. Maintenance et Dépannage

### 5.1 Vider le Cache
Lors d'une mise à jour en production, il est impératif de vider le cache :
```bash
php bin/console cache:clear --env=prod
```

### 5.2 Valider le Schéma de Base de Données
Si vous modifiez des Entités, vérifiez que le code est synchronisé avec la base de données :
```bash
php bin/console doctrine:schema:validate
```
Si le schéma n'est pas à jour, générez une migration :
```bash
php bin/console make:migration
php bin/console doctrine:migrations:migrate
```

### 5.3 Logs et Erreurs
- Les erreurs d'exécution se trouvent dans : `var/log/prod.log` (ou `dev.log`).
- Pour les erreurs 500, vérifiez les permissions d'écriture sur les dossiers `var/cache/` et `var/log/`.

## 6. Sauvegarde

- **Base de données :** Mettez en place un cron effectuant un `mysqldump` régulier.
- **Code source :** Maintenez à jour votre branche `main` sur Git. Aucun fichier uploadé n'étant stocké pour l'instant (images hébergées extérieurement ou non existantes), une sauvegarde de la BDD suffit à garantir la pérennité des données.
