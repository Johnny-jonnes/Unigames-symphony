<?php

namespace App\Repository;

use App\Entity\Joueur;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Joueur>
 */
class JoueurRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Joueur::class);
    }
    public function countByEdition(int $editionId, ?int $disciplineId = null): int
    {
        $qb = $this->createQueryBuilder('j')
            ->select('COUNT(j.id)')
            ->join('j.equipe', 'e')
            ->where('e.edition = :edition')
            ->setParameter('edition', $editionId);

        if ($disciplineId) {
            $qb->andWhere('e.discipline = :discipline')
               ->setParameter('discipline', $disciplineId);
        }

        return (int) $qb->getQuery()->getSingleScalarResult();
    }

    public function findByEdition(int $editionId, ?int $disciplineId = null): array
    {
        $qb = $this->createQueryBuilder('j')
            ->join('j.equipe', 'e')
            ->where('e.edition = :edition')
            ->setParameter('edition', $editionId);

        if ($disciplineId) {
            $qb->andWhere('e.discipline = :discipline')
               ->setParameter('discipline', $disciplineId);
        }

        return $qb->getQuery()->getResult();
    }

    public function findByEditionGroupedByEquipe(int $editionId, ?int $disciplineId = null): array
    {
        $qb = $this->createQueryBuilder('j')
            ->join('j.equipe', 'e')
            ->where('e.edition = :edition')
            ->setParameter('edition', $editionId);

        if ($disciplineId) {
            $qb->andWhere('e.discipline = :discipline')
               ->setParameter('discipline', $disciplineId);
        }

        $joueurs = $qb->getQuery()->getResult();
        
        $grouped = [];
        foreach ($joueurs as $joueur) {
            $equipeId = $joueur->getEquipe()->getId();
            if (!isset($grouped[$equipeId])) {
                $grouped[$equipeId] = [
                    'equipe' => $joueur->getEquipe(),
                    'joueurs' => []
                ];
            }
            $grouped[$equipeId]['joueurs'][] = $joueur;
        }

        return array_values($grouped);
    }
}
