<?php

namespace App\Repository;

use App\Entity\RatingsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method RatingsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method RatingsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method RatingsEntity[]    findAll()
 * @method RatingsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class RatingsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, RatingsEntity::class);
    }

    public function ratingRegionCalculate($id)
    {
        return $this->createQueryBuilder('rate')
            ->select('avg(rate.rate)')
            ->andWhere('rate.region = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
