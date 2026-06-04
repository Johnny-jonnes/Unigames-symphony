<?php

namespace App\EventSubscriber;

use App\Repository\DisciplineRepository;
use App\Repository\EditionRepository;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpKernel\Event\ControllerEvent;
use Symfony\Component\HttpKernel\KernelEvents;
use Twig\Environment;

class ContextSubscriber implements EventSubscriberInterface
{
    private EditionRepository $editionRepository;
    private DisciplineRepository $disciplineRepository;
    private Environment $twig;

    public function __construct(EditionRepository $editionRepository, DisciplineRepository $disciplineRepository, Environment $twig)
    {
        $this->editionRepository = $editionRepository;
        $this->disciplineRepository = $disciplineRepository;
        $this->twig = $twig;
    }

    public function onKernelController(ControllerEvent $event): void
    {
        $request = $event->getRequest();
        
        // Load all editions for the selector
        $allEditions = $this->editionRepository->findAll();
        $this->twig->addGlobal('all_editions', $allEditions);

        $activeEditionId = $request->getSession()->get('active_edition_id');
        $activeEdition = null;
        if ($activeEditionId) {
            $activeEdition = $this->editionRepository->find($activeEditionId);
        }
        $this->twig->addGlobal('active_edition', $activeEdition);

        // Load all disciplines for the selector
        $allDisciplines = $activeEditionId ? $this->disciplineRepository->findByEdition($activeEditionId) : [];
        $this->twig->addGlobal('all_disciplines', $allDisciplines);

        $activeDisciplineId = $request->getSession()->get('active_discipline_id');
        $activeDiscipline = null;
        if ($activeDisciplineId) {
            $activeDiscipline = $this->disciplineRepository->find($activeDisciplineId);
        }
        $this->twig->addGlobal('active_discipline', $activeDiscipline);
    }

    public static function getSubscribedEvents(): array
    {
        return [
            KernelEvents::CONTROLLER => 'onKernelController',
        ];
    }
}
