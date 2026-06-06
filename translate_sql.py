# -*- coding: utf-8 -*-
import os

input_file = os.path.join("docs", "unigames_database.sql")
output_file = os.path.join("docs", "unigames_database_translated.sql")

translations = {
    "-- MySQL dump": "-- Dump MySQL",
    "-- Host:": "-- Hôte :",
    "-- Server version": "-- Version du serveur",
    "-- Table structure for table": "-- Structure de la table pour",
    "-- Dumping data for table": "-- Déchargement des données de la table",
    "-- Current Database:": "-- Base de données actuelle :",
    "-- Dumping routines for database": "-- Déchargement des routines pour la base de données",
    "-- Dumping events for database": "-- Déchargement des événements pour la base de données",
    "-- Position to start replication or point-in-time recovery from": "-- Position pour démarrer la réplication ou la récupération à un point dans le temps",
    "-- GTID state at the beginning of the backup": "-- État GTID au début de la sauvegarde"
}

try:
    with open(input_file, 'r', encoding='utf-16') as f:
        lines = f.readlines()

    with open(output_file, 'w', encoding='utf-8') as f:
        for line in lines:
            new_line = line
            for en, fr in translations.items():
                if new_line.startswith(en):
                    new_line = new_line.replace(en, fr)
            f.write(new_line)

    # Overwrite the original file
    os.replace(output_file, input_file)
    print("Traduction terminee avec succes.")
except Exception as e:
    print(f"Erreur: {e}")
