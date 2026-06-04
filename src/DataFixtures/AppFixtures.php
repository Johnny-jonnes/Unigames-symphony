<?php

namespace App\DataFixtures;

use App\Entity\Discipline;
use App\Entity\Edition;
use App\Entity\Faculte;
use App\Entity\User;
use App\Entity\Equipe;
use App\Entity\Joueur;
use App\Entity\MatchGame;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class AppFixtures extends Fixture
{
    private UserPasswordHasherInterface $hasher;

    public function __construct(UserPasswordHasherInterface $hasher)
    {
        $this->hasher = $hasher;
    }

    public function load(ObjectManager $manager): void
    {
        // 1. Users
        $admin = new User();
        $admin->setEmail('admin@unigames.com');
        $admin->setName('Administrateur');
        $admin->setRoles(['ROLE_ADMIN']);
        $admin->setPassword($this->hasher->hashPassword($admin, 'password'));
        $manager->persist($admin);

        $staff = new User();
        $staff->setEmail('staff@unigames.com');
        $staff->setName('Staff User');
        $staff->setRoles(['ROLE_STAFF']);
        $staff->setPassword($this->hasher->hashPassword($staff, 'password'));
        $manager->persist($staff);

        $viewer = new User();
        $viewer->setEmail('lecteur@unigames.com');
        $viewer->setName('Lecteur');
        $viewer->setRoles(['ROLE_VIEWER']);
        $viewer->setPassword($this->hasher->hashPassword($viewer, 'password'));
        $manager->persist($viewer);

        // 2. Édition
        $edition = new Edition();
        $edition->setNom('Jeux Universitaires 2025');
        $edition->setDateDebut(new \DateTime('2025-05-01'));
        $edition->setDateFin(new \DateTime('2025-05-31'));
        $manager->persist($edition);

        // 3. Disciplines
        $football = new Discipline();
        $football->setNom('Football');
        $football->setNombreJoueursParEquipe(11);
        $manager->persist($football);

        $basket = new Discipline();
        $basket->setNom('Basketball');
        $basket->setNombreJoueursParEquipe(5);
        $manager->persist($basket);

        $volley = new Discipline();
        $volley->setNom('Volleyball');
        $volley->setNombreJoueursParEquipe(6);
        $manager->persist($volley);

        // 4. Facultés
        $facsData = ['Sciences', 'Médecine', 'Polytechnique', 'Arts'];
        $facultes = [];
        foreach ($facsData as $facNom) {
            $fac = new Faculte();
            $fac->setNom('Faculté des ' . $facNom);
            $fac->setUniversite('Campus Principal');
            $fac->setEdition($edition);
            $manager->persist($fac);
            $facultes[$facNom] = $fac;
        }
        
        // Fix names
        $facultes['Sciences']->setNom('Sciences');
        $facultes['Médecine']->setNom('Médecine');
        $facultes['Polytechnique']->setNom('Polytechnique');
        $facultes['Arts']->setNom('Arts');

        // 5. Équipes (Football)
        $eqSciences = new Equipe();
        $eqSciences->setNom('Sciences FC');
        $eqSciences->setFaculte($facultes['Sciences']);
        $eqSciences->setDiscipline($football);
        $eqSciences->setEdition($edition);
        $manager->persist($eqSciences);

        $eqMedecine = new Equipe();
        $eqMedecine->setNom('Médecine United');
        $eqMedecine->setFaculte($facultes['Médecine']);
        $eqMedecine->setDiscipline($football);
        $eqMedecine->setEdition($edition);
        $manager->persist($eqMedecine);

        $eqPolytech = new Equipe();
        $eqPolytech->setNom('Polytech Strikers');
        $eqPolytech->setFaculte($facultes['Polytechnique']);
        $eqPolytech->setDiscipline($football);
        $eqPolytech->setEdition($edition);
        $manager->persist($eqPolytech);

        $eqArts = new Equipe();
        $eqArts->setNom('Arts & Culture FC');
        $eqArts->setFaculte($facultes['Arts']);
        $eqArts->setDiscipline($football);
        $eqArts->setEdition($edition);
        $manager->persist($eqArts);

        // 6. Joueurs
        $j1 = new Joueur();
        $j1->setPrenom('Samuel');
        $j1->setNom('EKOTO');
        $j1->setNumero(9);
        $j1->setSexe('M');
        $j1->setEquipe($eqSciences);
        $manager->persist($j1);
        
        $j2 = new Joueur();
        $j2->setPrenom('Jean');
        $j2->setNom('BAPTISTE');
        $j2->setNumero(10);
        $j2->setSexe('M');
        $j2->setEquipe($eqSciences);
        $manager->persist($j2);

        $j3 = new Joueur();
        $j3->setPrenom('Marc');
        $j3->setNom('ANTOINE');
        $j3->setNumero(1);
        $j3->setSexe('M');
        $j3->setEquipe($eqMedecine);
        $manager->persist($j3);

        // 7. Matchs
        $match1 = new MatchGame();
        $match1->setDateMatch(new \DateTime('2025-05-10 14:00:00'));
        $match1->setLieu('Stade Principal');
        $match1->setPhase('Poules');
        $match1->setEdition($edition);
        $match1->setDiscipline($football);
        $match1->setEquipeA($eqSciences);
        $match1->setEquipeB($eqMedecine);
        $match1->setScoreA(3);
        $match1->setScoreB(1);
        $match1->setStatut('joue');
        
        $buteursData = [
            'equipe_a' => [
                ['id' => 1, 'nb_buts' => 2, 'nom' => 'Samuel EKOTO', 'minute' => '12'],
                ['id' => 2, 'nb_buts' => 1, 'nom' => 'Jean BAPTISTE', 'minute' => '45']
            ],
            'equipe_b' => [
                ['id' => 3, 'nb_buts' => 1, 'nom' => 'Marc ANTOINE', 'minute' => '78']
            ]
        ];
        $match1->setButeurs($buteursData);
        $manager->persist($match1);

        $match2 = new MatchGame();
        $match2->setDateMatch(new \DateTime('2025-05-11 16:00:00'));
        $match2->setLieu('Terrain B');
        $match2->setPhase('Poules');
        $match2->setEdition($edition);
        $match2->setDiscipline($football);
        $match2->setEquipeA($eqPolytech);
        $match2->setEquipeB($eqArts);
        $match2->setScoreA(0);
        $match2->setScoreB(0);
        $match2->setStatut('joue');
        $manager->persist($match2);

        $match3 = new MatchGame();
        $match3->setDateMatch(new \DateTime('2025-05-30 18:00:00'));
        $match3->setLieu('Stade Olympique');
        $match3->setPhase('Finale');
        $match3->setEdition($edition);
        $match3->setDiscipline($football);
        $match3->setEquipeA($eqSciences);
        $match3->setEquipeB($eqPolytech);
        $match3->setStatut('planifie');
        $manager->persist($match3);

        $manager->flush();
    }
}
