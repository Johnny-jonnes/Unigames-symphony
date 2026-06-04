<?php

namespace App\Controller;

use App\Entity\Discipline;
use App\Form\DisciplineType;
use App\Repository\DisciplineRepository;
use App\Repository\EditionRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/disciplines')]
class DisciplineController extends AbstractController
{
    #[Route('/', name: 'app_discipline_index', methods: ['GET'])]
    public function index(Request $request, DisciplineRepository $disciplineRepository): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $disciplines = $activeEditionId ? $disciplineRepository->findByEdition($activeEditionId) : [];

        return $this->render('discipline/index.html.twig', [
            'disciplines' => $disciplines,
        ]);
    }

    #[Route('/new', name: 'app_discipline_new', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function new(Request $request, EntityManagerInterface $entityManager, EditionRepository $editionRepository): Response
    {
        $discipline = new Discipline();
        
        $activeEditionId = $request->getSession()->get('active_edition_id');
        if ($activeEditionId) {
            $discipline->setEdition($editionRepository->find($activeEditionId));
        }

        $form = $this->createForm(DisciplineType::class, $discipline, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($discipline);
            $entityManager->flush();

            $this->addFlash('success', 'La discipline a été ajoutée avec succès.');
            return $this->redirectToRoute('app_discipline_index');
        }

        return $this->render('discipline/new.html.twig', [
            'discipline' => $discipline,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_discipline_edit', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function edit(Request $request, Discipline $discipline, EntityManagerInterface $entityManager): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $form = $this->createForm(DisciplineType::class, $discipline, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            $this->addFlash('success', 'La discipline a été mise à jour.');
            return $this->redirectToRoute('app_discipline_index');
        }

        return $this->render('discipline/edit.html.twig', [
            'discipline' => $discipline,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/delete', name: 'app_discipline_delete', methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function delete(Request $request, Discipline $discipline, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$discipline->getId(), $request->request->get('_token'))) {
            $entityManager->remove($discipline);
            $entityManager->flush();
            $this->addFlash('success', 'La discipline a été supprimée.');
        }

        return $this->redirectToRoute('app_discipline_index');
    }
}
