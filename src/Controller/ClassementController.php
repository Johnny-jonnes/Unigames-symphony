<?php

namespace App\Controller;

use App\Repository\DisciplineRepository;
use App\Repository\EditionRepository;
use App\Repository\EquipeRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/classements')]
class ClassementController extends AbstractController
{
    #[Route('/', name: 'app_classement_index', methods: ['GET'])]
    public function index(
        Request $request,
        EditionRepository $editionRepository,
        DisciplineRepository $disciplineRepository,
        EquipeRepository $equipeRepository
    ): Response {
        $editionId = $request->query->get('edition') ?: $request->getSession()->get('active_edition_id');
        $disciplineId = $request->query->get('discipline') ?: $request->getSession()->get('active_discipline_id');

        $editions = $editionRepository->findAll();
        $disciplines = $disciplineRepository->findAll();

        $classement = [];
        if ($disciplineId && $editionId) {
            $equipes = $equipeRepository->findBy([
                'edition' => $editionId,
                'discipline' => $disciplineId
            ]);

            foreach ($equipes as $equipe) {
                $stats = [
                    'equipe' => $equipe,
                    'points' => 0,
                    'matchs_joues' => 0,
                    'victoires' => 0,
                    'nuls' => 0,
                    'defaites' => 0,
                    'buts_pour' => 0,
                    'buts_contre' => 0,
                    'difference' => 0,
                ];

                foreach ($equipe->getAllMatchs() as $match) {
                    if ($match->getStatut() !== 'joue') continue;

                    $stats['matchs_joues']++;
                    $isEquipeA = ($match->getEquipeA() === $equipe);
                    $scoreMoi = $isEquipeA ? $match->getScoreA() : $match->getScoreB();
                    $scoreLui = $isEquipeA ? $match->getScoreB() : $match->getScoreA();

                    $stats['buts_pour'] += $scoreMoi;
                    $stats['buts_contre'] += $scoreLui;

                    if ($scoreMoi > $scoreLui) {
                        $stats['victoires']++;
                        $stats['points'] += 3;
                    } elseif ($scoreMoi === $scoreLui) {
                        $stats['nuls']++;
                        $stats['points'] += 1;
                    } else {
                        $stats['defaites']++;
                    }
                }
                $stats['difference'] = $stats['buts_pour'] - $stats['buts_contre'];
                $classement[] = $stats;
            }

            // Tri du classement : Points DESC, Différence DESC, Buts Pour DESC
            usort($classement, function ($a, $b) {
                if ($a['points'] !== $b['points']) return $b['points'] <=> $a['points'];
                if ($a['difference'] !== $b['difference']) return $b['difference'] <=> $a['difference'];
                return $b['buts_pour'] <=> $a['buts_pour'];
            });
        }

        return $this->render('classement/index.html.twig', [
            'editions' => $editions,
            'disciplines' => $disciplines,
            'classement' => $classement,
            'selectedEdition' => $editionId,
            'selectedDiscipline' => $disciplineId,
        ]);
    }
}
