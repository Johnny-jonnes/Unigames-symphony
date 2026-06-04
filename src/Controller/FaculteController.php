<?php

namespace App\Controller;

use App\Entity\Faculte;
use App\Form\FaculteType;
use App\Repository\EditionRepository;
use App\Repository\FaculteRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/facultes')]
class FaculteController extends AbstractController
{
    #[Route('/', name: 'app_faculte_index', methods: ['GET'])]
    public function index(Request $request, FaculteRepository $faculteRepository, EditionRepository $editionRepository): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $activeEdition = $activeEditionId ? $editionRepository->find($activeEditionId) : null;
        $activeDisciplineId = $request->getSession()->get('active_discipline_id');

        $facultes = $activeEdition
            ? $faculteRepository->findByEdition($activeEdition->getId(), $activeDisciplineId)
            : [];

        return $this->render('faculte/index.html.twig', [
            'facultes' => $facultes,
            'activeEdition' => $activeEdition,
        ]);
    }

    #[Route('/new', name: 'app_faculte_new', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function new(Request $request, EntityManagerInterface $entityManager, EditionRepository $editionRepository): Response
    {
        $faculte = new Faculte();
        
        $activeEditionId = $request->getSession()->get('active_edition_id');
        if ($activeEditionId) {
            $faculte->setEdition($editionRepository->find($activeEditionId));
        }

        $form = $this->createForm(FaculteType::class, $faculte, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($faculte);
            $entityManager->flush();

            $this->addFlash('success', 'La faculté a été créée avec succès.');
            return $this->redirectToRoute('app_faculte_index');
        }

        return $this->render('faculte/new.html.twig', [
            'faculte' => $faculte,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_faculte_edit', methods: ['GET', 'POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function edit(Request $request, Faculte $faculte, EntityManagerInterface $entityManager): Response
    {
        $activeEditionId = $request->getSession()->get('active_edition_id');
        $form = $this->createForm(FaculteType::class, $faculte, ['edition_id' => $activeEditionId]);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            $this->addFlash('success', 'La faculté a été mise à jour.');
            return $this->redirectToRoute('app_faculte_index');
        }

        return $this->render('faculte/edit.html.twig', [
            'faculte' => $faculte,
            'form' => $form,
        ]);
    }

    #[Route('/{id}/delete', name: 'app_faculte_delete', methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function delete(Request $request, Faculte $faculte, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$faculte->getId(), $request->request->get('_token'))) {
            $entityManager->remove($faculte);
            $entityManager->flush();
            $this->addFlash('success', 'La faculté a été supprimée.');
        }

        return $this->redirectToRoute('app_faculte_index');
    }
}
