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

            ->select('regions.id', 'regions.name', 'regions.description', 'regions.location', 'count(comments) as commentNumber',
                            'avg(rate.rate) as ratingAverage', 'images.path as path' )

            ->from('App:RatingsEntity','rate')
            //->innerJoin('regions.id', 'regions', Join::ON, 'rate.region = regions.id')
            ->from('App:CommentsEntity','comments')
            ->from('App:ImagesEntity', 'images')

            ->andWhere('images.region=regions.id')
            ->andWhere('rate.region=regions.id')
            ->andWhere('comments.region=regions.id')
            ->groupBy('regions.id')
            ->groupBy('rate.region')
            ->orderBy('regions.id', 'ASC')

            ->getQuery()
            ->getResult();
    }
}
