<?php

namespace App\Controller;

use App\Entity\Equipe;
use App\Form\EquipeType;
use App\Repository\EditionRepository;
use App\Repository\EquipeRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/equipes')]
class EquipeController extends AbstractController
{
    #[Route('/', name: 'app_equipe_index', methods: ['GET'])]
    public function index(Request $request, EquipeRepository $equipeRepository, EditionRepository $editionRepository): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $activeEdition = $activeEditionId ? $editionRepository->find($activeEditionId) : null;
        $activeDisciplineId = $request->getSession()->get('active_discipline_id');

        $equipes = $activeEdition
            ? $equipeRepository->findByEdition($activeEdition->getId(), $activeDisciplineId)
            : [];

        return $this->render('equipe/index.html.twig', [
            'equipes' => $equipes,
            'activeEdition' => $activeEdition,
        ]);
    }

    #[Route('/new', name: 'app_equipe_new', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function new(Request $request, EntityManagerInterface $entityManager, EditionRepository $editionRepository): Response
    {
        $equipe = new Equipe();
        
        $activeEditionId = $request->getSession()->get('active_edition_id');
        if ($activeEditionId) {
            $equipe->setEdition($editionRepository->find($activeEditionId));
        }

        $form = $this->createForm(EquipeType::class, $equipe, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($equipe);
            $entityManager->flush();

            $this->addFlash('success', 'L\'équipe a été ajoutée avec succès.');
            return $this->redirectToRoute('app_equipe_index');
        }

        return $this->render('equipe/new.html.twig', [
            'equipe' => $equipe,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_equipe_edit', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function edit(Request $request, Equipe $equipe, EntityManagerInterface $entityManager): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $form = $this->createForm(EquipeType::class, $equipe, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            $this->addFlash('success', 'L\'équipe a été mise à jour.');
            return $this->redirectToRoute('app_equipe_index');
        }

        return $this->render('equipe/edit.html.twig', [
            'equipe' => $equipe,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/delete', name: 'app_equipe_delete', methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function delete(Request $request, Equipe $equipe, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$equipe->getId(), $request->request->get('_token'))) {
            $entityManager->remove($equipe);
            $entityManager->flush();
            $this->addFlash('success', 'L\'équipe a été supprimée.');
        }

        return $this->redirectToRoute('app_equipe_index');
    }
}
