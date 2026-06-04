<?php

namespace App\Repository;

use App\Entity\MatchGame;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<MatchGame>
 */
class MatchGameRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, MatchGame::class);
    }
    public function countByEdition(int $editionId, ?int $disciplineId = null, array $criteria = []): int
    {
        $qb = $this->createQueryBuilder('m')
            ->select('COUNT(m.id)')
            ->where('m.edition = :edition')
            ->setParameter('edition', $editionId);
            
        if ($disciplineId) {
            $qb->andWhere('m.discipline = :discipline')
               ->setParameter('discipline', $disciplineId);
        }
            
        foreach ($criteria as $key => $value) {
            $qb->andWhere("m.$key = :$key")
               ->setParameter($key, $value);
        }

        return (int) $qb->getQuery()->getSingleScalarResult();
    }

    public function findByEdition(int $editionId, ?int $disciplineId = null, ?array $orderBy = null, ?int $limit = null, ?int $offset = null): array
    {
        $qb = $this->createQueryBuilder('m')
            ->where('m.edition = :edition')
            ->setParameter('edition', $editionId);

        if ($disciplineId) {
            $qb->andWhere('m.discipline = :discipline')
               ->setParameter('discipline', $disciplineId);
        }

        if ($orderBy) {
            foreach ($orderBy as $field => $order) {
                $qb->addOrderBy("m.$field", $order);
            }
        }
        if ($limit) {
            $qb->setMaxResults($limit);
        }
        if ($offset) {
            $qb->setFirstResult($offset);
        }

        return $qb->getQuery()->getResult();
    }
}
