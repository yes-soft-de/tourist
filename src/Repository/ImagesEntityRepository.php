<?php

namespace App\Repository;

use App\Entity\ImagesEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method ImagesEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method ImagesEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method ImagesEntity[]    findAll()
 * @method ImagesEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ImagesEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, ImagesEntity::class);
    }

    public function getRegionImages($id)
    {
        return $this->createQueryBuilder('images')
            ->select('images.path')

            ->andWhere('images.region = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getResult();
    }

    public function getRegionImage($id)
    {
        return $this->createQueryBuilder('images')
            ->andWhere('images.region = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getEventImages($id)
    {
        return $this->createQueryBuilder('images')
            ->select('images.path')

            ->andWhere('images.event = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getResult();
    }

    public function getEventImage($id)
    {
        return $this->createQueryBuilder('images')
        
            ->andWhere('images.event = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }
}
