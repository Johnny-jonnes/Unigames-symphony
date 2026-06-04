<?php

namespace App\Repository;

use App\Entity\Faculte;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Faculte>
 */
class FaculteRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Faculte::class);
    }
    public function countByEdition(int $editionId, ?int $disciplineId = null): int
    {
        $qb = $this->createQueryBuilder('f')
            ->select('COUNT(DISTINCT f.id)')
            ->where('f.edition = :edition')
            ->setParameter('edition', $editionId);

        if ($disciplineId) {
            $qb->join('f.equipes', 'e')
               ->andWhere('e.discipline = :discipline')
               ->setParameter('discipline', $disciplineId);
        }

        return (int) $qb->getQuery()->getSingleScalarResult();
    }

    public function findByEdition(int $editionId, ?int $disciplineId = null): array
    {
        $qb = $this->createQueryBuilder('f')
            ->where('f.edition = :edition')
            ->setParameter('edition', $editionId);

        if ($disciplineId) {
            $qb->join('f.equipes', 'e')
               ->andWhere('e.discipline = :discipline')
               ->setParameter('discipline', $disciplineId);
        }

        return $qb->getQuery()->getResult();
    }
}

