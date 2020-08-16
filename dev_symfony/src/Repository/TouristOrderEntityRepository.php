<?php

namespace App\Repository;

use App\Entity\TouristOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method TouristOrderEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method TouristOrderEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method TouristOrderEntity[]    findAll()
 * @method TouristOrderEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class TouristOrderEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, TouristOrderEntity::class);
    }

    public function getOrderByTourist($touristID)
    {
        //dd($touristID);

        $e = $this->createQueryBuilder('orders')
            ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.guidUserID', 'orders.city', 'orders.language',
                'orders.arriveDate', 'orders.leaveDate', 'orders.roomID', 'orders.cost', 'orders.status')

            ->andWhere('orders.touristUserID=:touristID')
            ->setParameter('touristID', $touristID)
            ->groupBy('orders.id')
            ->orderBy('orders.id', 'ASC')

            ->getQuery()
            ->getResult();

        return $e;
    }

    public function getOrderByGuidCityAndLanguage($city, $language)
    {
        $res = [];

        foreach ($city as $c)
        {
            foreach ($language as $l)
            {
                $order = $this->createQueryBuilder('orders')
                    ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.city', 'orders.language', 'orders.services',
                        'orders.arriveDate', 'orders.leaveDate', 'orders.cost', 'orders.status')

                    ->andWhere('orders.city = :city')
                    ->setParameter('city', $c)
                    ->andWhere('orders.language = :language')
                    ->setParameter('language', $l)
                    ->andWhere('orders.status = :pending')
                    ->setParameter('pending', 'pending')

                    ->getQuery()
                    ->getResult();

                if($order)
                {
                    $res[]=$order;
                }

            }
        }

        if ($res)
        {
            return $res[0];
        }
        else
        {
            return $res;
        }
    }

    public function getOrdersByGuidUserID($guidUserID)
    {
        $e = $this->createQueryBuilder('orders')
        ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.guidUserID', 'orders.city', 'orders.language',
            'orders.arriveDate', 'orders.leaveDate', 'orders.roomID', 'orders.cost', 'orders.status')

        ->andWhere('orders.guidUserID=:guidID')
        ->setParameter('guidID', $guidUserID)
        ->groupBy('orders.id')
        ->orderBy('orders.id', 'ASC')

        ->getQuery()
        ->getResult();

    return $e;
    }
}
