<?php
$mermaid = <<<EOD
classDiagram
    class Edition {
        +int id
        +string nom
        +datetime date_debut
        +datetime date_fin
    }
    class Discipline {
        +int id
        +string nom
        +text description
        +int nombre_joueurs_par_equipe
        +int edition_id
    }
    class Faculte {
        +int id
        +string nom
        +string universite
        +int edition_id
    }
    class Equipe {
        +int id
        +string nom
        +int faculte_id
        +int discipline_id
        +int edition_id
    }
    class Joueur {
        +int id
        +string nom
        +string prenom
        +string sexe
        +int numero
        +int equipe_id
    }
    class MatchGame {
        +int id
        +datetime date_match
        +string lieu
        +string phase
        +int score_a
        +int score_b
        +string statut
        +json buteurs
        +int equipeA_id
        +int equipeB_id
        +int discipline_id
        +int edition_id
    }
    class User {
        +int id
        +string email
        +string name
        +string role
        +string password
    }

    Edition "1" --> "*" Discipline
    Edition "1" --> "*" Faculte
    Edition "1" --> "*" Equipe
    Edition "1" --> "*" MatchGame
    Discipline "1" --> "*" Equipe
    Discipline "1" --> "*" MatchGame
    Faculte "1" --> "*" Equipe
    Equipe "1" --> "*" Joueur
    Equipe "1" --> "*" MatchGame : equipeA
    Equipe "1" --> "*" MatchGame : equipeB
EOD;

$json = json_encode(['diagram_source' => $mermaid]);

$ch = curl_init('https://kroki.io/mermaid/png');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $json);
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Content-Type: application/json',
    'Accept: image/png'
]);

// Handle proxy or SSL issues
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

$response = curl_exec($ch);
if (curl_errno($ch)) {
    echo "cURL Error: " . curl_error($ch) . "\n";
} else {
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    if ($httpCode === 200) {
        if (!is_dir('docs/images')) {
            mkdir('docs/images', 0777, true);
        }
        file_put_contents('docs/images/uml_classes.png', $response);
        echo "UML image saved successfully!\n";
    } else {
        echo "HTTP Error: $httpCode\n";
        echo $response . "\n";
    }
}
curl_close($ch);
