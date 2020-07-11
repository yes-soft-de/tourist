<?php

namespace App\Repository;

use App\Entity\GuidEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method GuidEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method GuidEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method GuidEntity[]    findAll()
 * @method GuidEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class GuidEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, GuidEntity::class);
    }

    public function getGuid($userID)
    {
        return $this->createQueryBuilder('guid')
            ->andWhere('guid.user =:userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getGuidByRegion($city)
    {
        $r =  $this->createQueryBuilder('guid')
            ->select('IDENTITY(guid.user) as user', 'guid.name', 'guid.status', 'guid.language', 'guid.city', 'guid.path as image')
            ->andWhere('guid.city LIKE :city')
            ->setParameter('city',  '%' . $city  . '%')

            ->getQuery()
            ->getResult();

        //dd($r);

        return $r;
    }

    public function getGuides()
    {
        return $this->createQueryBuilder('guid')
            ->select('IDENTITY(guid.user) as user', 'guid.name', 'guid.status', 'guid.language', 'guid.city', 'guid.path as image',
                'userEntity.userID as userID')

            ->from('App:User', 'userEntity')
            ->andWhere('userEntity.id = IDENTITY(guid.user)')

            ->getQuery()
            ->getResult();
    }
}
