<?php

namespace App\Controller;

use App\Repository\EditionRepository;
use App\Repository\EquipeRepository;
use App\Repository\FaculteRepository;
use App\Repository\JoueurRepository;
use App\Repository\MatchGameRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DashboardController extends AbstractController
{
    #[Route('/', name: 'app_dashboard')]
    public function index(
        Request $request,
        EditionRepository $editionRepository,
        EquipeRepository $equipeRepository,
        JoueurRepository $joueurRepository,
        MatchGameRepository $matchRepository,
        FaculteRepository $faculteRepository
    ): Response {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $activeEdition = $activeEditionId ? $editionRepository->find($activeEditionId) : null;

        if (!$activeEdition) {
            return $this->render('dashboard/index.html.twig', [
                'activeEdition' => null,
                'stats' => null,
                'recentMatchs' => [],
            ]);
        }

        $id = $activeEdition->getId();
        $activeDisciplineId = $request->getSession()->get('active_discipline_id');

        return $this->render('dashboard/index.html.twig', [
            'activeEdition' => $activeEdition,
            'stats' => [
                'equipes'       => $equipeRepository->countByEdition($id, $activeDisciplineId),
                'joueurs'       => $joueurRepository->countByEdition($id, $activeDisciplineId),
                'facultes'      => $faculteRepository->countByEdition($id, $activeDisciplineId),
                'matchs_joues'  => $matchRepository->countByEdition($id, $activeDisciplineId, ['statut' => 'joue']),
                'matchs_avenir' => $matchRepository->countByEdition($id, $activeDisciplineId, ['statut' => 'planifie']) 
                                 + $matchRepository->countByEdition($id, $activeDisciplineId, ['statut' => 'en_cours']),
            ],
            'recentMatchs' => $matchRepository->findByEdition($id, $activeDisciplineId, ['date_match' => 'DESC'], 5),
        ]);
    }
}
