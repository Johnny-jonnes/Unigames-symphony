# Cahier des Charges - UniGames

**Date :** 3 Juin 2026
**Projet :** UniGames
**Version :** 1.0

## 1. Contexte et Objectifs

### 1.1 Contexte
Le projet UniGames est une plateforme web développée pour répondre aux besoins de gestion des compétitions sportives universitaires (Jeux Universitaires). 

### 1.2 Objectif Principal
L'objectif est de permettre aux administrateurs, au staff sportif et au public (lecteurs) de gérer, suivre et administrer des tournois sportifs regroupant plusieurs universités, répartis sur différentes éditions annuelles ou événementielles.

## 2. Périmètre du Projet

La plateforme couvre :
- La gestion globale des **éditions** (ex: UniGames 2025, 2027).
- L'administration des **disciplines sportives** spécifiques à chaque édition.
- L'inscription et la gestion des **facultés** participantes.
- La gestion des **équipes** (rattachées à une faculté, une discipline et une édition).
- Le référencement des **joueurs** constituant les équipes.
- La programmation et le suivi des **matchs**.
- Le calcul automatisé et la consultation des **classements**.

## 3. Description des Acteurs

| Rôle | Description | Droits et Permissions |
|------|-------------|-----------------------|
| **Administrateur** (`ROLE_ADMIN`) | Superviseur de la plateforme. | Accès total. Gestion des éditions, disciplines, facultés, équipes, utilisateurs, joueurs et matchs. |
| **Staff** (`ROLE_STAFF`) | Responsable sportif / Arbitre. | Gestion des équipes, des joueurs, création des matchs et saisie des scores/buteurs. |
| **Lecteur / Public** (`ROLE_VIEWER`) | Étudiant, fan ou participant. | Consultation des tableaux de bord, des listes, des matchs et des classements (Lecture seule). |

## 4. Exigences Fonctionnelles

### 4.1 Gestion Multi-Éditions
- Le système doit permettre de créer plusieurs éditions.
- Un sélecteur global de contexte (en session) doit permettre de filtrer toutes les vues pour n'afficher que les données relatives à l'édition sélectionnée.

### 4.2 Module Disciplines
- Chaque édition possède son propre catalogue de disciplines sportives.
- Possibilité de définir le nombre de joueurs requis par équipe pour une discipline donnée.

### 4.3 Module Équipes et Joueurs
- Création d'équipes rattachées à une faculté et une discipline.
- Ajout de joueurs (Nom, Prénom, Sexe, Numéro de maillot) dans une équipe spécifique.

### 4.4 Module Compétition (Matchs et Scores)
- Planification des matchs (Date, Lieu, Phase de la compétition).
- Les matchs opposent deux équipes (`Equipe A` et `Equipe B`) de la même discipline.
- Saisie des scores et enregistrement détaillé des buteurs.
- Cycle de vie d'un match : *Planifié*, *En cours*, *Joué*.

### 4.5 Classements Automatiques
- Calcul dynamique basé sur les matchs au statut *Joué*.
- Barème : Victoire = 3 points, Nul = 1 point, Défaite = 0 point.
- Critères de départage (tri) : Points (DESC) > Différence de buts (DESC) > Buts marqués (DESC).

### 4.6 Tableau de Bord (Dashboard)
- Affichage de statistiques globales pour l'édition en cours (Nombre d'équipes, de joueurs, de matchs joués, de matchs à venir).
- Affichage des 5 derniers matchs.

## 5. Exigences Non-Fonctionnelles

### 5.1 Sécurité
- Authentification requise pour tout accès (sauf pages publiques si configurées).
- Mots de passe hashés de manière sécurisée en base de données.
- Protection CSRF sur tous les formulaires d'édition et de suppression.
- Isolation des accès par rôle (`IsGranted`).

### 5.2 Expérience Utilisateur (UX)
- Interface moderne, réactive et intuitive.
- Filtrage en temps réel dans les formulaires via des listes déroulantes intelligentes (Context-Aware).
- Menus latéraux et topbar pour une navigation fluide.

### 5.3 Performances
- Requêtes optimisées via Doctrine ORM.
- Calcul des classements à la volée optimisé.

## 6. Contraintes Techniques
- **Framework backend :** Symfony 7.x
- **Langage :** PHP 8.x
- **ORM :** Doctrine
- **Base de données :** MySQL / MariaDB
- **Moteur de templates :** Twig
- **Styling :** CSS / TailwindCSS / Alpine.js (pour les interactions UI)

## 7. Glossaire
- **Édition :** Un événement global se déroulant sur une période donnée (ex: UniGames Hiver 2026).
- **Contexte :** Mécanisme stockant en session l'Édition et/ou la Discipline actuellement consultée par l'utilisateur pour filtrer dynamiquement les données affichées.
- **Phase :** L'étape d'un tournoi pour un match (ex: Poules, Quart de finale, Finale).
