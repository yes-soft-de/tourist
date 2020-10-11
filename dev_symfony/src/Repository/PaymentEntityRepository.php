<?php

namespace App\Repository;

use App\Entity\GuidEntity;
use App\Entity\PaymentEntity;
use App\Entity\User;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\ORM\Query\Expr\Join;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method PaymentEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method PaymentEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method PaymentEntity[]    findAll()
 * @method PaymentEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class PaymentEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, PaymentEntity::class);
    }

    public function getPayments()
    {
        return $this->createQueryBuilder('payment')
            ->select('payment.id', 'payment.touristUserID', 'user.name as touristName', 'payment.guidUserID',
                'guid.name as guidName', 'payment.date', 'payment.token',
                'payment.payment', 'payment.createdAt', 'payment.updatedAt')

            ->leftJoin(
                User::class,              //Entity
                'user',                        //Alias
                Join::WITH,              //Join Type
                'user.userID = payment.touristUserID'  //Join Column
            )

            ->leftJoin(
                User::class,              //Entity
                'guid',                        //Alias
                Join::WITH,              //Join Type
                'guid.userID = payment.guidUserID'  //Join Column
            )

            ->getQuery()
            ->getResult();
    }

    public function getPaymentByTouristID($id)
    {
        return $this->createQueryBuilder('payment')
            ->select('payment.id', 'payment.touristUserID', 'user.name as touristName', 'payment.guidUserID',
                'guid.name as guidName', 'payment.date', 'payment.token',
                'payment.payment', 'payment.createdAt', 'payment.updatedAt')

            ->leftJoin(
                User::class,              //Entity
                'user',                        //Alias
                Join::WITH,              //Join Type
                'user.userID = payment.touristUserID'  //Join Column
            )

            ->leftJoin(
                User::class,              //Entity
                'guid',                        //Alias
                Join::WITH,              //Join Type
                'guid.userID = payment.guidUserID'  //Join Column
            )


            ->andWhere('payment.touristUserID =:id')
            ->setParameter('id', $id)
            ->getQuery()

            ->getResult();
    }

    public function getPaymentByGuidID($id)
    {
        return $this->createQueryBuilder('payment')
            ->select('payment.id', 'payment.touristUserID', 'user.name as touristName', 'payment.guidUserID',
                'guid.name as guidName', 'payment.date', 'payment.token',
                'payment.payment', 'payment.createdAt', 'payment.updatedAt')

            ->leftJoin(
                User::class,              //Entity
                'user',                        //Alias
                Join::WITH,              //Join Type
                'user.userID = payment.touristUserID'  //Join Column
            )

            ->leftJoin(
                User::class,              //Entity
                'guid',                        //Alias
                Join::WITH,              //Join Type
                'guid.userID = payment.guidUserID'  //Join Column
            )

            ->andWhere('payment.guidUserID =:id')
            ->setParameter('id', $id)
            ->getQuery()

            ->getResult();
    }

    public function getPaymentByID($id)
    {
        return  $this->createQueryBuilder('payment')
            ->select('payment.id', 'payment.touristUserID', 'user.name as touristName', 'payment.guidUserID',
                'guid.name as guidName', 'payment.date', 'payment.token',
                'payment.payment', 'payment.createdAt', 'payment.updatedAt')

            ->leftJoin(
                User::class,              //Entity
                'user',                        //Alias
                Join::WITH,              //Join Type
                'user.userID = payment.touristUserID'  //Join Column
            )

            ->leftJoin(
                User::class,              //Entity
                'guid',                        //Alias
                Join::WITH,              //Join Type
                'guid.userID = payment.guidUserID'  //Join Column
            )

            ->andWhere('payment.id =:id')
            ->setParameter('id', $id)
            ->getQuery()

            ->getResult();
    }
}
