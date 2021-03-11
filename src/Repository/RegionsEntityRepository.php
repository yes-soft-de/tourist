<?php

namespace App\Repository;

use App\Entity\RegionsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

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

            ->select('regions.id', 'regions.name', 'regions.description', 'regions.location', 'regions.placeId')

            ->groupBy('regions.id')
            ->orderBy('regions.id', 'ASC')

            ->getQuery()
            ->getResult();
    }

    public function getRegion($id)
    {
        return $this->createQueryBuilder('regions')

            ->select('regions.id', 'regions.name', 'regions.description', 'regions.location', 'regions.placeId')

            ->andWhere('regions.id=:id')
            ->setParameter('id',$id)

            ->getQuery()
            //->getArrayResult();
            ->getOneOrNullResult();
    }

    public function getRegionByPlaceID($placeId)
    {
        return $this->createQueryBuilder('regions')

            ->select('regions.id', 'regions.name', 'regions.description', 'regions.location', 'regions.location', 'regions.placeId')

            ->andWhere('regions.placeId=:placeId')
            ->setParameter('placeId',$placeId)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
