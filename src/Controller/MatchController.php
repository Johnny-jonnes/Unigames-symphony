<?php

namespace App\Controller;

use App\Entity\MatchGame;
use App\Form\MatchGameType;
use App\Repository\DisciplineRepository;
use App\Repository\EditionRepository;
use App\Repository\MatchGameRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/matchs')]
class MatchController extends AbstractController
{
    #[Route('/', name: 'app_match_index', methods: ['GET'])]
    public function index(Request $request, MatchGameRepository $matchRepository, EditionRepository $editionRepository): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $activeEdition = $activeEditionId ? $editionRepository->find($activeEditionId) : null;
        $activeDisciplineId = $request->getSession()->get('active_discipline_id');

        $matchs = $activeEdition
            ? $matchRepository->findByEdition($activeEdition->getId(), $activeDisciplineId, ['date_match' => 'DESC'])
            : [];

        return $this->render('match/index.html.twig', [
            'matchs' => $matchs,
            'activeEdition' => $activeEdition,
        ]);
    }

    #[Route('/new', name: 'app_match_new', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_STAFF')]
    public function new(Request $request, EntityManagerInterface $entityManager, EditionRepository $editionRepository, DisciplineRepository $disciplineRepository): Response
    {
        $match = new MatchGame();
        $match->setStatut('programme');
        $match->setScoreA(0);
        $match->setScoreB(0);
        
        $activeEditionId = $request->getSession()->get('active_edition_id');
        if ($activeEditionId) {
            $match->setEdition($editionRepository->find($activeEditionId));
        }

        $activeDisciplineId = $request->getSession()->get('active_discipline_id');
        if ($activeDisciplineId) {
            $match->setDiscipline($disciplineRepository->find($activeDisciplineId));
        }
        
        $form = $this->createForm(MatchGameType::class, $match, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($match);
            $entityManager->flush();

            $this->addFlash('success', 'Le match a été programmé avec succès.');
            return $this->redirectToRoute('app_match_index');
        }

        return $this->render('match/new.html.twig', [
            'match' => $match,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_match_show', methods: ['GET'])]
    public function show(MatchGame $match): Response
    {
        return $this->render('match/show.html.twig', [
            'match' => $match,
        ]);
    }

    #[Route('/{id}/saisir-score', name: 'app_match_score', methods: ['POST'])]
    #[IsGranted('ROLE_STAFF')]
    public function saisirScore(Request $request, MatchGame $match, EntityManagerInterface $entityManager): Response
    {
        $scoreA = $request->request->get('score_a');
        $scoreB = $request->request->get('score_b');
        $buteursData = $request->request->all('buteurs') ?? [];

        $match->setScoreA((int)$scoreA);
        $match->setScoreB((int)$scoreB);
        $match->setButeurs($buteursData);
        $match->setStatut('joue');

        $entityManager->flush();

        $this->addFlash('success', 'Le score a été enregistré avec succès.');

        return $this->redirectToRoute('app_match_show', ['id' => $match->getId()]);
    }

    #[Route('/{id}/edit', name: 'app_match_edit', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_STAFF')]
    public function edit(Request $request, MatchGame $match, EntityManagerInterface $entityManager): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $form = $this->createForm(MatchGameType::class, $match, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            $this->addFlash('success', 'Le match a été mis à jour.');
            return $this->redirectToRoute('app_match_index');
        }

        return $this->render('match/edit.html.twig', [
            'match' => $match,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/delete', name: 'app_match_delete', methods: ['POST'])]
    #[IsGranted('ROLE_STAFF')]
    public function delete(Request $request, MatchGame $match, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$match->getId(), $request->request->get('_token'))) {
            $entityManager->remove($match);
            $entityManager->flush();
            $this->addFlash('success', 'Le match a été supprimé.');
        }

        return $this->redirectToRoute('app_match_index');
    }
}
