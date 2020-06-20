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

    // /**
    //  * @return ImagesEntity[] Returns an array of ImagesEntity objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('i')
            ->andWhere('i.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('i.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    /*
    public function findOneBySomeField($value): ?ImagesEntity
    {
        return $this->createQueryBuilder('i')
            ->andWhere('i.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
