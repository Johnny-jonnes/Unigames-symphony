# Portfolio d'Interface - UniGames (Présentation Finale)

**Date :** 4 Juin 2026
**Client / Projet :** Plateforme de Gestion Sportive Universitaire "UniGames"

> [!IMPORTANT]
> Ce document présente l'interface finale de l'application web UniGames telle qu'elle a été développée et déployée. Les captures ci-dessous reflètent le fonctionnement réel, le rendu responsif (TailwindCSS) et le thème sombre professionnel implémenté.

---

## 1. Vue d'Ensemble & Tableau de Bord

Cette section présente l'entrée dans l'application, incluant la page de connexion sécurisée et le tableau de bord (Dashboard) compilant les statistiques globales de l'édition en cours.

````carousel
![Écran de Connexion (Login)](images/Capture d’écran_4-6-2026_214135_localhost.jpeg)
<!-- slide -->
![Tableau de bord - Statistiques](images/Capture d’écran_4-6-2026_214158_localhost.jpeg)
<!-- slide -->
![Tableau de bord - Détails](images/Capture d’écran_4-6-2026_214243_localhost.jpeg)
<!-- slide -->
![Navigation et Menus](images/Capture d’écran_4-6-2026_214357_localhost.jpeg)
````

> [!TIP]
> **Expérience Utilisateur (UX) :** Le design utilise le style *Glassmorphism* et un thème sombre profond (`#0D1F3C`) avec des accents bleus (`#005BAA`) pour donner un aspect "Premium" et sportif.

---

## 2. Administration et Gestion des Entités

L'administration au jour le jour permet de configurer les éditions, disciplines, facultés et d'inscrire les équipes et joueurs. Le sélecteur global (en haut à droite) permet de filtrer ces vues contextuellement.

````carousel
![Gestion des Éditions](images/Capture d’écran_4-6-2026_214429_localhost.jpeg)
<!-- slide -->
![Liste des Disciplines](images/Capture d’écran_4-6-2026_214443_localhost.jpeg)
<!-- slide -->
![Gestion des Facultés](images/Capture d’écran_4-6-2026_214537_localhost.jpeg)
<!-- slide -->
![Liste des Équipes](images/Capture d’écran_4-6-2026_21459_localhost.jpeg)
<!-- slide -->
![Inscription des Joueurs](images/Capture d’écran_4-6-2026_214710_localhost.jpeg)
<!-- slide -->
![Formulaires de création](images/Capture d’écran_4-6-2026_214851_localhost.jpeg)
````

> [!NOTE]
> Tous les tableaux de données sont interactifs et bénéficient d'une pagination native pour supporter un grand nombre d'enregistrements (ex: des centaines de joueurs).

---

## 3. Module Compétition (Matchs & Classements)

Le cœur de l'application : l'organisation des matchs, la saisie des scores en direct et la consultation des classements dynamiques.

````carousel
![Calendrier des Matchs](images/Capture d’écran_4-6-2026_214920_localhost.jpeg)
<!-- slide -->
![Détail d'un Match (Équipes, Phase, Lieu)](images/Capture d’écran_4-6-2026_214939_localhost.jpeg)
<!-- slide -->
![Saisie des scores et des buteurs](images/Capture d’écran_4-6-2026_214952_localhost.jpeg)
<!-- slide -->
![Validation d'un résultat](images/Capture d’écran_4-6-2026_21496_localhost.jpeg)
<!-- slide -->
![Calcul du Classement Général (Aperçu 1)](images/Capture d’écran_4-6-2026_215027_localhost.jpeg)
<!-- slide -->
![Calcul du Classement Général (Aperçu 2)](images/Capture d’écran_4-6-2026_215044_localhost.jpeg)
<!-- slide -->
![Progression et Statistiques](images/Capture d’écran_4-6-2026_215126_localhost.jpeg)
<!-- slide -->
![Filtres Dynamiques du Classement](images/Capture d’écran_4-6-2026_21560_localhost.jpeg)
````

> [!IMPORTANT]
> **Calcul Automatique :** Le système de classement illustré dans les captures ci-dessus ne stocke rien en base. Il calcule les points, différences de buts et statistiques à la volée en se basant sur les matchs au statut "Joué" appartenant à l'Édition sélectionnée !
