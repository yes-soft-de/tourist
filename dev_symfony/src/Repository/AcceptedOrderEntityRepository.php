<?php

namespace App\Repository;

use App\Entity\AcceptedOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method AcceptedOrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method AcceptedOrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method AcceptedOrderEntity[]    findAll()
 * @method AcceptedOrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class AcceptedOrderEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, AcceptedOrderEntity::class);
    }

    public function getAcceptedOrder($userID)
    {
        $r = $this->createQueryBuilder('acceptedOrder')
            ->select('acceptedOrder.id', 'acceptedOrder.orderID', 'acceptedOrder.cost', 'acceptedOrder.date', 'acceptedOrder.status', 'acceptedOrder.guidUserID',
                'acceptedOrder.touristUserID', 'touristOrder as order')

            ->join('App:TouristOrderEntity', 'touristOrder')

            ->andWhere('touristOrder.id = acceptedOrder.orderID')

            ->andWhere('acceptedOrder.touristUserID=:id')
            ->setParameter('id', $userID)

            ->andWhere('acceptedOrder.status=:status')
            ->setParameter('status', 'pending')

            ->getQuery()
            ->getArrayResult();

        return $r;
    }
}
