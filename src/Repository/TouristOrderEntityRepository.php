<?php

namespace App\Repository;

use App\Entity\RegionsEntity;
use App\Entity\TouristOrderEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;
use Doctrine\ORM\Query\Expr\Join;

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
        // Get only accepted orders
        $e = $this->createQueryBuilder('orders')
            ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.guidUserID', 'orders.city', 'orders.language', 'orders.services',
                'orders.arriveDate', 'orders.leaveDate', 'orders.roomID', 'orders.cost', 'orders.status', 'acceptedOrderEntity.uuid')

            ->join('App:AcceptedOrderEntity', 'acceptedOrderEntity')

            ->andWhere('orders.id = acceptedOrderEntity.orderID')

            ->andWhere('orders.touristUserID=:touristID')
            ->setParameter('touristID', $touristID)
            ->groupBy('orders.id')
            ->orderBy('orders.id', 'ASC')

            ->getQuery()
            ->getResult();

        return $e;
    }

    public function getAllOrdersByTouristID($touristID)
    {
        // Get all orders of a tourist either they are accepted or not
        return $this->createQueryBuilder('orders')
            ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.guidUserID', 'orders.city as area', 'orders.language', 'orders.services',
                'orders.arriveDate', 'orders.leaveDate', 'orders.roomID', 'orders.cost', 'orders.status', 'region_entity.name as city')

            ->andWhere('orders.touristUserID = :touristID')
            ->setParameter('touristID', $touristID)
            
            ->andWhere('orders.status = :pending')
            ->setParameter('pending', 'pending')

            ->leftJoin(
                RegionsEntity::class,
                'region_entity',
                Join::WITH,
                'region_entity.placeId = orders.city'
            )

            ->groupBy('orders.id')
            ->orderBy('orders.id', 'ASC')

            ->getQuery()
            ->getResult();
    }

    public function getOrderByGuidCityAndLanguage($city, $language)
    {
        $res = [];

        foreach ($city as $c)
        {
            foreach ($language as $l)
            {
                $order = $this->createQueryBuilder('orders')
                    ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.city as area', 'orders.language', 'orders.services',
                        'orders.arriveDate', 'orders.leaveDate', 'orders.cost', 'orders.status', 'region_entity.name as city')

                    ->andWhere('orders.city = :city')
                    ->setParameter('city', $c)
                    
                    ->andWhere('orders.language = :language')
                    ->setParameter('language', $l)

                    ->andWhere('orders.status = :pending')
                    ->setParameter('pending', 'pending')

                    ->leftJoin(
                        RegionsEntity::class,
                        'region_entity',
                        Join::WITH,
                        'region_entity.placeId = orders.city'
                    )

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

    //Get orders with undefined guidUserID
    public function getOrdersByGuideCitiesAndLanguages($cities, $languages)
    {
        $res = [];

        foreach ($cities as $city)
        {
            foreach ($languages as $language)
            {
                $order = $this->createQueryBuilder('orders')
                    ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.city', 'orders.language', 'orders.services',
                        'orders.arriveDate', 'orders.leaveDate', 'orders.cost', 'orders.status')

                    ->andWhere('orders.city = :city')
                    ->setParameter('city', $city)

                    ->andWhere('orders.language = :language')
                    ->setParameter('language', $language)

                    ->andWhere('orders.status = :pending')
                    ->setParameter('pending', 'pending')

                    ->andWhere('orders.guidUserID is NULL')

                    ->getQuery()
                    ->getResult();

                if($order)
                {
                    $res[] = $order;
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
            ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.guidUserID', 'orders.city', 'orders.language', 'orders.services',
            'orders.arriveDate', 'orders.leaveDate', 'orders.roomID', 'orders.cost', 'orders.status', 'acceptedOrderEntity.uuid')

            ->join('App:AcceptedOrderEntity', 'acceptedOrderEntity')

            ->andWhere('orders.id = acceptedOrderEntity.orderID')
            ->andWhere('orders.guidUserID=:guidID')
            ->setParameter('guidID', $guidUserID)
            ->groupBy('orders.id')
            ->orderBy('orders.id', 'ASC')

            ->getQuery()
            ->getResult();

             return $e;
    }

    public function getOrdersByGuideIdForDashboard($guideID)
    {
        return $this->createQueryBuilder('orders')
            ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.guidUserID', 'orders.city as area', 'orders.language', 'orders.services',
            'orders.arriveDate', 'orders.leaveDate', 'orders.roomID', 'acceptedOrderEntity.cost', 'acceptedOrderEntity.status', 'acceptedOrderEntity.uuid',
            'region_entity.name as city')

            ->join('App:AcceptedOrderEntity', 'acceptedOrderEntity')
            ->andWhere('orders.id = acceptedOrderEntity.orderID')

            ->leftJoin(
                RegionsEntity::class,
                'region_entity',
                Join::WITH,
                'region_entity.placeId = orders.city'
            )

            ->andWhere('orders.guidUserID=:guidID')
            ->setParameter('guidID', $guideID)

            ->groupBy('orders.id')
            ->orderBy('orders.id', 'ASC')

            ->getQuery()
            ->getResult();

    }

    public function getOrderByID($id)
    {
        return $this->createQueryBuilder('orders')

            ->andWhere('orders.id = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getResult();
    }

    public function getUnacceptedOrders()
    {
        return $this->createQueryBuilder('orders')
            ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.guidUserID', 'orders.city', 'orders.language', 'orders.services',
            'orders.arriveDate', 'orders.leaveDate', 'orders.cost', 'userEntity1.name as guideName', 'userEntity2.name as touristName')

            ->join('App:User', 'userEntity1')
            ->andWhere('userEntity1.userID = orders.guidUserID')

            ->join('App:User', 'userEntity2')
            ->andWhere('userEntity2.userID = orders.touristUserID')
            
            ->groupBy('orders.id')
            ->orderBy('orders.id', 'ASC')

            ->getQuery()
            ->getResult();

    }
}
