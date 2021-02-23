<?php

namespace App\Repository;

use App\Entity\CommentsEntity;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;

/**
 * @method CommentsEntity|null find($id, $lockMode = null, $lockVersion = null)
 * @method CommentsEntity|null findOneBy(array $criteria, array $orderBy = null)
 * @method CommentsEntity[]    findAll()
 * @method CommentsEntity[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class CommentsEntityRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, CommentsEntity::class);
    }

    public function getCommentsByID($id)
    {
        $r = $this->createQueryBuilder('comments')
            ->select('comments.id', 'comments.comment', 'comments.date', 'user.name as userName', 'user.roles')
            //->from('App:User', 'user')
            ->join('App:User', 'user')
            //'IDENTITY(comments.region)'
            //->join('App:RegionEntity', 'region')
            ->andWhere('user.id = comments.user')

            ->andWhere('comments.region=:id')
            ->setParameter('id',$id)

            ->getQuery()
            ->getArrayResult();

        return $r;
    }

    public function commentsNumber($id)
    {
        return $this->createQueryBuilder('commentNumber')
            ->select('count(commentNumber)')
            ->andWhere('commentNumber.region = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();
    }

    public function eventCommentsNumber($id)
    {
        $r = $this->createQueryBuilder('commentNumber')
            ->select('count(commentNumber)')
            ->andWhere('commentNumber.event = :id')
            ->setParameter('id', $id)

            ->getQuery()
            ->getOneOrNullResult();

        //dd($r);
        return $r;
    }

    public function getEventCommentsByID($id)
    {
        $r = $this->createQueryBuilder('comments')
            ->select('comments.id', 'comments.comment', 'comments.date', 'user.name as userName')
            //->from('App:User', 'user')
            ->join('App:User', 'user')
            ->andWhere('user.id = comments.user')

            ->andWhere('comments.event=:id')
            ->setParameter('id',$id)

            ->getQuery()
            ->getArrayResult();


        return $r;
    }
}
