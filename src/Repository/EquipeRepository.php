<?php

namespace App\Repository;

use App\Entity\Equipe;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Equipe>
 */
class EquipeRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Equipe::class);
    }
    public function countByEdition(int $editionId, ?int $disciplineId = null): int
    {
        $qb = $this->createQueryBuilder('e')
            ->select('COUNT(e.id)')
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
        $qb = $this->createQueryBuilder('e')
            ->where('e.edition = :edition')
            ->setParameter('edition', $editionId);
            
        if ($disciplineId) {
            $qb->andWhere('e.discipline = :discipline')
               ->setParameter('discipline', $disciplineId);
        }
            
        return $qb->getQuery()->getResult();
    }
}
