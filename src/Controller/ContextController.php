<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ContextController extends AbstractController
{
    #[Route('/context/edition/{id}', name: 'app_context_edition', methods: ['POST'])]
    public function setEdition(int $id, Request $request): Response
    {
        $request->getSession()->set('active_edition_id', $id);
        
        $referer = $request->headers->get('referer');
        return $referer ? $this->redirect($referer) : $this->redirectToRoute('app_dashboard');
    }

    #[Route('/context/discipline/clear', name: 'app_context_discipline_clear', methods: ['POST'])]
    public function clearDiscipline(Request $request): Response
    {
        $request->getSession()->remove('active_discipline_id');
        
        $referer = $request->headers->get('referer');
        return $referer ? $this->redirect($referer) : $this->redirectToRoute('app_dashboard');
    }

    #[Route('/context/discipline/{id}', name: 'app_context_discipline', methods: ['POST'])]
    public function setDiscipline(int $id, Request $request): Response
    {
        $request->getSession()->set('active_discipline_id', $id);
        
        $referer = $request->headers->get('referer');
        return $referer ? $this->redirect($referer) : $this->redirectToRoute('app_dashboard');
    }
}
