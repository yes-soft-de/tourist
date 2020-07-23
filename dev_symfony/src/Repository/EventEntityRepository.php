<?php

namespace App\Repository;

use App\Entity\EventEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method EventEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method EventEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method EventEntity[]    findAll()
 * @method EventEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class EventEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, EventEntity::class);
    }


    public function getEvents()
    {
        return $this->createQueryBuilder('events')

            ->select('events.id', 'events.name', 'events.date', 'events.description', 'events.location', 'events.status', 'events.type', 'events.subType')

            ->orderBy('events.id', 'ASC')

            ->getQuery()
            ->getResult();
    }

    public function getEventByID($id)
    {
        return $this->createQueryBuilder('events')

            ->select('events.id', 'events.name', 'events.date', 'events.description', 'events.location', 'events.status', 'events.type', 'events.subType')

            ->andWhere('events.id=:id')
            ->setParameter('id',$id)

            ->getQuery()

            ->getOneOrNullResult();
    }


}
