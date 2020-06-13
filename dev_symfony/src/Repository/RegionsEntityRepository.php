<?php

namespace App\Repository;

use App\Entity\RegionsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method RegionsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RegionsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RegionsEntity[]    findAll()
 * @method RegionsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RegionsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RegionsEntity::class);
    }

    public function getRegions()
    {
        return $this->createQueryBuilder('regions')

            ->select('regions.id', 'regions.name', 'regions.description', 'regions.location')

            ->orderBy('regions.id', 'ASC')

            ->getQuery()
            ->getResult();
    }
}
