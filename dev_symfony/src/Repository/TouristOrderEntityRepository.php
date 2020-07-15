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
        $order = $this->createQueryBuilder('orders')
            ->select('orders.id', 'orders.date', 'orders.touristUserID', 'orders.city', 'orders.language', 'orders.services',
                'orders.arriveDate', 'orders.leaveDate', 'orders.cost', 'orders.status');

        foreach ($city as $c)
        {
            foreach ($language as $l)
            {
                $order
                    ->andWhere('orders.touristUserID like :city')
                    ->setParameter('city', '%' . $c[0]  . '%')
                    ->andWhere('orders.touristUserID like :language')
                    ->setParameter('language', '%' . $l[0]  . '%')
                    ->andWhere('orders.status = :pending')
                    ->setParameter('pending', 'pending');
            }
        }

        $res = $order
            ->groupBy('orders.id')
            ->orderBy('orders.id', 'ASC')

            ->getQuery()
            ->getResult();

        return $res;
    }
}
