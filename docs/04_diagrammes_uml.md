# Diagrammes UML - UniGames

**Date :** 3 Juin 2026
**Projet :** UniGames

Ce document présente les diagrammes modélisant l'architecture et les processus de la plateforme UniGames.

## 1. Diagramme de Classes

Ce diagramme illustre les entités du projet et leurs relations (généré à partir de l'architecture réelle).

![Diagramme de classes UML](images/uml_classes.png)

## 2. Diagramme de Cas d'Utilisation

Ce diagramme présente les interactions possibles entre les acteurs et le système.

```mermaid
usecaseDiagram
    actor Viewer as "Lecteur (Public)"
    actor Staff as "Staff Sportif"
    actor Admin as "Administrateur"

    usecase UC1 as "Consulter tableau de bord"
    usecase UC2 as "Consulter les matchs"
    usecase UC3 as "Consulter les classements"
    
    usecase UC4 as "Gérer les équipes"
    usecase UC5 as "Gérer les joueurs"
    usecase UC6 as "Programmer des matchs"
    usecase UC7 as "Saisir les scores et buteurs"
    
    usecase UC8 as "Gérer les éditions"
    usecase UC9 as "Gérer les disciplines"
    usecase UC10 as "Gérer les facultés"
    usecase UC11 as "Gérer les utilisateurs"

    Viewer --> UC1
    Viewer --> UC2
    Viewer --> UC3

    Staff --> UC1
    Staff --> UC2
    Staff --> UC3
    Staff --> UC4
    Staff --> UC5
    Staff --> UC6
    Staff --> UC7

    Admin --> UC1
    Admin --> UC2
    Admin --> UC3
    Admin --> UC4
    Admin --> UC5
    Admin --> UC6
    Admin --> UC7
    Admin --> UC8
    Admin --> UC9
    Admin --> UC10
    Admin --> UC11
```

## 3. Diagramme de Séquence : Saisie de Score

Ce diagramme montre le processus de sauvegarde d'un résultat de match.

```mermaid
sequenceDiagram
    participant Staff as Utilisateur (Staff)
    participant Browser as Navigateur Web
    participant MatchCtrl as MatchController
    participant DB as Doctrine EntityManager

    Staff->>Browser: Remplit le formulaire de score (score A, score B, buteurs)
    Staff->>Browser: Clique sur "Enregistrer"
    Browser->>MatchCtrl: POST /matchs/{id}/saisir-score
    activate MatchCtrl
    MatchCtrl->>MatchCtrl: Récupère & valide la requête POST
    MatchCtrl->>MatchCtrl: setScoreA(), setScoreB(), setButeurs(), setStatut('joue')
    MatchCtrl->>DB: flush()
    activate DB
    DB-->>MatchCtrl: Confirmation SQL UPDATE
    deactivate DB
    MatchCtrl-->>Browser: RedirectResponse (flash 'success')
    deactivate MatchCtrl
    Browser-->>Staff: Affiche le match mis à jour
```

## 4. Diagramme de Séquence : Changement de Contexte (Édition)

Ce diagramme explique comment le système filtre globalement l'application.

```mermaid
sequenceDiagram
    participant User as Utilisateur
    participant Browser as Navigateur
    participant ContextCtrl as ContextController
    participant Session as Session Symfony

    User->>Browser: Sélectionne l'édition "2027" dans le header
    Browser->>ContextCtrl: POST /context/edition/2
    activate ContextCtrl
    ContextCtrl->>Session: set('active_edition_id', 2)
    ContextCtrl->>Session: remove('active_discipline_id')
    ContextCtrl-->>Browser: Redirect to referer (URL précédente)
    deactivate ContextCtrl
    Browser-->>User: Recharge la page avec les données filtrées pour 2027
```

## 5. Diagramme d'Activité : Processus de Match

Ce diagramme détaille le cycle de vie d'un match.

```mermaid
stateDiagram-v2
    [*] --> Planifie: Création du match
    
    Planifie --> EnCours: Début du match (Optionnel)
    Planifie --> Joue: Saisie directe du score
    EnCours --> Joue: Fin du match / Saisie du score
    
    state Joue {
        [*] --> Calcul
        Calcul --> Classement: Ajout des points (V=3, N=1, D=0)
        Classement --> [*]
    }
    
    Joue --> [*]
```

## 6. Modèle Logique de Données (MLD)

```mermaid
erDiagram
    EDITION ||--o{ DISCIPLINE : "possède"
    EDITION ||--o{ FACULTE : "inscrit"
    EDITION ||--o{ EQUIPE : "inclut"
    EDITION ||--o{ MATCHS : "planifie"
    
    DISCIPLINE ||--o{ EQUIPE : "pratiquée par"
    DISCIPLINE ||--o{ MATCHS : "définit"
    
    FACULTE ||--o{ EQUIPE : "représentée par"
    
    EQUIPE ||--o{ JOUEUR : "composée de"
    EQUIPE ||--o{ MATCHS : "joue (A ou B)"

    USERS {
        int id PK
        varchar email
        varchar role
        varchar password
    }
```
