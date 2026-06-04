# Manuel d'Utilisation - UniGames

**Date :** 3 Juin 2026
**Projet :** UniGames

Bienvenue sur le guide d'utilisation officiel de la plateforme **UniGames**. Ce manuel vous accompagnera dans l'utilisation quotidienne de l'application.

---

## 1. Introduction et Prérequis

La plateforme UniGames est accessible via n'importe quel navigateur web moderne (Chrome, Firefox, Safari, Edge). 

### 1.1 Connexion à la plateforme
Rendez-vous sur l'adresse URL fournie par votre administrateur. 
Saisissez votre adresse email et votre mot de passe pour accéder à votre espace de travail.

### 1.2 Rôles et Permissions
Votre affichage dépendra de votre niveau d'accès :
- **Lecteur (Gris) :** Vous pouvez uniquement consulter les informations et classements.
- **Staff (Vert) :** Vous pouvez gérer les équipes, les joueurs et saisir les scores des matchs.
- **Administrateur (Bleu) :** Vous avez le contrôle total sur l'application.

---

## 2. Le Concept de Contexte (Le Sélecteur en haut à droite)

> [!IMPORTANT]
> UniGames fonctionne avec un système de filtre global appelé **Contexte**. Dans la barre supérieure droite de votre écran, vous verrez toujours une liste déroulante d'**Édition** (ex: *UniGames 2025*). 

- **Ce que vous voyez est ce que vous sélectionnez.** Si vous sélectionnez l'édition "2027", l'ensemble de l'interface (Tableau de bord, Matchs, Équipes) ne vous montrera que les données de 2027.
- Vous pouvez affiner ce filtre en choisissant une **Discipline** spécifique. Pour revenir à la vue globale de l'édition, sélectionnez "Toutes les disciplines".

---

## 3. Guide pas à pas par module

### 3.1 Tableau de Bord (Dashboard)
Dès votre connexion, vous arrivez sur le **Tableau de bord**.
![Tableau de Bord](images/Capture d’écran_4-6-2026_214158_localhost.jpeg)
- **Cartes de statistiques :** Affichent le nombre total d'équipes, de joueurs, de facultés et de matchs pour l'édition sélectionnée.
- **Matchs Récents :** Un tableau récapitulatif des 5 derniers matchs.

### 3.2 Gestion des Éditions et Disciplines *(Admin)*
![Gestion des Éditions](images/Capture d’écran_4-6-2026_214429_localhost.jpeg)
- Allez dans **Éditions** pour créer un nouvel événement sportif annuel.
- Allez dans **Disciplines** pour ajouter les sports qui seront disputés (ex: Football, Basketball). Notez que les disciplines créées s'ajouteront automatiquement à l'édition actuellement sélectionnée dans la barre du haut.

### 3.3 Facultés et Équipes
1. **Facultés :** *(Admin)* Ajoutez les noms des facultés ou universités participantes.
2. **Équipes :** *(Staff/Admin)* Allez dans **Équipes > Nouvelle Équipe**.
   - Choisissez un nom.
   - Sélectionnez la Faculté.
   - Sélectionnez la Discipline. *(Note: seules les disciplines de l'édition active sont affichées).*

### 3.4 Inscription des Joueurs
Allez dans **Joueurs > Nouveau**.
1. Saisissez le Nom, Prénom, Sexe et Numéro de maillot.
2. **Astuce :** Pour trouver l'équipe facilement, utilisez le filtre "Discipline" dans le formulaire. Cela réduira la liste des équipes à celles pratiquant ce sport.
3. Cliquez sur Enregistrer.

### 3.5 Programmation et Saisie de Matchs
![Gestion des Matchs](images/Capture d’écran_4-6-2026_214920_localhost.jpeg)
1. **Création d'un match :** Allez dans **Matchs > Nouveau**. Définissez la date, le lieu, la phase (ex: *Quart de finale*), la discipline et les deux équipes affrontées.
2. **Saisir un score :** 
   - Cliquez sur le bouton "Saisir Score" (icône de sifflet ou stylo) à côté du match.
   - Entrez les buts marqués par l'Équipe A et l'Équipe B.
   - Ajoutez éventuellement les buteurs en utilisant le panneau JSON ou l'interface dédiée.
   - Validez. Le match passera au statut *Joué*.

### 3.6 Classements
![Tableau des Classements](images/Capture d’écran_4-6-2026_215027_localhost.jpeg)
Allez dans **Classements**.
- Utilisez les filtres en haut de page pour sélectionner l'Édition et la Discipline souhaitée.
- Le tableau affichera automatiquement le classement calculé (Victoire = 3 points, Nul = 1 point).
- Les colonnes signifient : **MJ** (Matchs Joués), **V** (Victoires), **N** (Nuls), **D** (Défaites), **BP** (Buts Pour), **BC** (Buts Contre), **Diff** (Différence de buts), **Pts** (Points totaux).

---

## 4. Dépannage Courant

> [!WARNING]
> **Problème :** Je ne vois pas l'équipe que je viens de créer dans la liste.
> **Solution :** Vérifiez le sélecteur d'édition en haut à droite. Il est fort probable que vous ayez créé l'équipe dans l'édition 2026, mais que votre sélecteur affiche l'édition 2025.

> [!WARNING]
> **Problème :** Je veux créer une équipe mais le menu déroulant "Discipline" est vide.
> **Solution :** Aucune discipline n'a encore été ajoutée pour cette édition. Demandez à un administrateur d'aller dans le menu "Disciplines" pour en ajouter une.

> [!WARNING]
> **Problème :** Le classement ne se met pas à jour.
> **Solution :** Un match n'est comptabilisé que s'il a le statut "Joué". Vérifiez dans la liste des matchs que vous avez bien enregistré le score final.
