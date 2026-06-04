# Spécifications Fonctionnelles et Techniques - UniGames

**Date :** 3 Juin 2026
**Projet :** UniGames

## 1. Architecture du Projet

UniGames est construit sur une architecture **MVC (Modèle-Vue-Contrôleur)** standard du framework **Symfony 7**. 

- **Modèles (Entity / Repository) :** Utilisent Doctrine ORM pour la persistance et l'interrogation de la base de données relationnelle.
- **Vues (Templates) :** Rendu côté serveur via **Twig**.
- **Contrôleurs :** Gèrent le routage, la sécurité (via attributs `#[IsGranted]`), et délèguent la logique complexe aux Repositories ou aux services.
- **Formulaires (FormType) :** Fortement typés, ils intègrent une logique de filtrage dynamique ("Context-Aware") grâce à des `query_builder`.
- **Événements (EventSubscriber) :** Un système global de contexte est géré par un écouteur d'événements (`ContextSubscriber`) branché sur le cycle de vie du Kernel Symfony.

## 2. Entités et Modèle de Données

Les données sont strictement organisées autour de l'entité centrale `Edition`.

### Relations Principales
- **Edition (1) ---> (N) Discipline :** Chaque édition possède son propre catalogue de disciplines.
- **Edition (1) ---> (N) Faculte :** Les facultés s'inscrivent à une édition.
- **Edition (1) ---> (N) Equipe :** Les équipes concourent dans le cadre d'une édition précise.
- **Edition (1) ---> (N) MatchGame :** Les matchs sont planifiés pour une édition.

### Relations Internes
- **Discipline (1) ---> (N) Equipe :** Une équipe pratique une discipline.
- **Discipline (1) ---> (N) MatchGame :** Un match est disputé dans une discipline.
- **Faculte (1) ---> (N) Equipe :** Une faculté peut avoir plusieurs équipes (dans différentes disciplines).
- **Equipe (1) ---> (N) Joueur :** Les joueurs composent l'équipe.
- **Equipe (1) ---> (N) MatchGame :** Relation double (comme `equipeA` ou `equipeB`).

## 3. Spécifications par Modules Fonctionnels

| Module | Contrôleur Associé | Description Fonctionnelle |
|--------|--------------------|---------------------------|
| **Authentification** | `SecurityController` | Gestion du login/logout natif Symfony. Redirection automatique si déjà connecté. |
| **Tableau de Bord** | `DashboardController` | Route racine (`/`). Compile les statistiques de l'édition active (Repositories custom : `countByEdition()`). |
| **Éditions** | `EditionController` | CRUD des éditions. |
| **Disciplines** | `DisciplineController` | CRUD des disciplines. Restreint par édition active en session. |
| **Facultés** | `FaculteController` | CRUD des facultés, avec filtrage par édition active. |
| **Équipes** | `EquipeController` | Création d'équipes en combinant Faculté + Discipline de la même édition. |
| **Joueurs** | `JoueurController` | CRUD des joueurs. Formulaire adaptatif filtrant les équipes en JavaScript (`data-discipline`). |
| **Matchs** | `MatchController` | Création de matchs, suivi du statut, et saisie complexe des scores et buteurs (format JSON). |
| **Classements** | `ClassementController` | Calcule les points dynamiquement à partir des données des matchs terminés (`joue`). |
| **Utilisateurs** | `UsersManagementController` | Espace Admin pour créer des staffs ou admins. Utilise `UserPasswordHasherInterface`. |
| **Contexte** | `ContextController` | Points d'entrée POST pour mettre à jour l'édition/discipline en session. |

## 4. Règles Métier

### 4.1 Système de Contexte (Session)
L'application repose sur un principe d'isolement temporel. L'utilisateur navigue toujours au sein d'une **Édition active**.
- Si l'utilisateur sélectionne l'édition "2027", l'ensemble de la navigation, des listes, et des formulaires d'ajout masqueront totalement les données relatives à "2025" ou "2026".
- L'injection de ce filtre se fait de manière transparente dans les vues via `ContextSubscriber` (`KernelEvents::CONTROLLER`).

### 4.2 Formulaires Dynamiques (Context-Aware)
Dans les formulaires comme `EquipeType` ou `MatchGameType`, l'`edition_id` est passé en option.
Les champs de type `EntityType` utilisent des closures de type `query_builder` pour ne proposer que les choix pertinents.

### 4.3 Calcul du Classement
- Le classement n'est pas stocké en base de données, il est calculé à la volée.
- **Barème :** Victoire = 3 pts, Nul = 1 pt, Défaite = 0 pt.
- **Critères de départage consécutifs :**
  1. Points accumulés (Décroissant).
  2. Différence de buts globale (Décroissant).
  3. Buts marqués (Décroissant).

### 4.4 Structure JSON des Buteurs
La base de données stocke les statistiques des buteurs de chaque match sous forme de tableau JSON dans la table `matchs`.
```json
{
  "equipe_a": [
    {"joueur_id": 1, "buts": 2},
    {"joueur_id": 4, "buts": 1}
  ],
  "equipe_b": [
    {"joueur_id": 12, "buts": 1}
  ]
}
```
La méthode `getDecodedButeurs()` de l'entité `MatchGame` gère les éventuels problèmes de double-encodage JSON robustement.

## 5. Matrice des Droits d'Accès

| Module / Action | `ROLE_VIEWER` | `ROLE_STAFF` | `ROLE_ADMIN` |
|-----------------|:-----------:|:----------:|:----------:|
| **Consultation générale** | Autorisé | Autorisé | Autorisé |
| **CRUD Joueurs** | Interdit | Autorisé | Autorisé |
| **CRUD Matchs & Scores** | Interdit | Autorisé | Autorisé |
| **CRUD Éditions / Disciplines** | Interdit | Interdit | Autorisé |
| **CRUD Facultés / Équipes** | Interdit | Interdit | Autorisé |
| **Gestion Utilisateurs** | Interdit | Interdit | Autorisé |
