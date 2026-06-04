<?php

namespace App\Controller;

use App\Entity\Joueur;
use App\Form\JoueurType;
use App\Repository\EditionRepository;
use App\Repository\JoueurRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/joueurs')]
class JoueurController extends AbstractController
{
    #[Route('/', name: 'app_joueur_index', methods: ['GET'])]
    public function index(Request $request, JoueurRepository $joueurRepository, EditionRepository $editionRepository): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $activeEdition = $activeEditionId ? $editionRepository->find($activeEditionId) : null;
        $activeDisciplineId = $request->getSession()->get('active_discipline_id');

        $equipes_grouped = $activeEdition
            ? $joueurRepository->findByEditionGroupedByEquipe($activeEdition->getId(), $activeDisciplineId)
            : [];

        $joueurs = $activeEdition
            ? $joueurRepository->findByEdition($activeEdition->getId(), $activeDisciplineId)
            : [];

        return $this->render('joueur/index.html.twig', [
            'joueurs' => $joueurs,
            'equipes_grouped' => $equipes_grouped,
            'activeEdition' => $activeEdition,
        ]);
    }

    #[Route('/new', name: 'app_joueur_new', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_STAFF')]
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $joueur = new Joueur();
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $form = $this->createForm(JoueurType::class, $joueur, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($joueur);
            $entityManager->flush();

            $this->addFlash('success', 'Le joueur a été enregistré avec succès.');
            return $this->redirectToRoute('app_joueur_index');
        }

        return $this->render('joueur/new.html.twig', [
            'joueur' => $joueur,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_joueur_edit', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_STAFF')]
    public function edit(Request $request, Joueur $joueur, EntityManagerInterface $entityManager): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $form = $this->createForm(JoueurType::class, $joueur, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            $this->addFlash('success', 'Le joueur a été mis à jour.');
            return $this->redirectToRoute('app_joueur_index');
        }

        return $this->render('joueur/edit.html.twig', [
            'joueur' => $joueur,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/delete', name: 'app_joueur_delete', methods: ['POST'])]
    #[IsGranted('ROLE_STAFF')]
    public function delete(Request $request, Joueur $joueur, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$joueur->getId(), $request->request->get('_token'))) {
            $entityManager->remove($joueur);
            $entityManager->flush();
            $this->addFlash('success', 'Le joueur a été supprimé.');
        }

        return $this->redirectToRoute('app_joueur_index');
    }
}
