<?php

namespace App\Repository;

use App\Entity\User;
use App\Request\TouristRegisterRequest;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Common\Persistence\ManagerRegistry;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;
use Symfony\Component\Security\Core\User\PasswordUpgraderInterface;
use Symfony\Component\Security\Core\User\UserInterface;

/**
 * @method User|null find($id, $lockMode = null, $lockVersion = null)
 * @method User|null findOneBy(array $criteria, array $orderBy = null)
 * @method User[]    findAll()
 * @method User[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class UserRepository extends ServiceEntityRepository implements PasswordUpgraderInterface
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, User::class);
    }

    /**
     * Used to upgrade (rehash) the user's password automatically over time.
     */
    public function upgradePassword(UserInterface $user, string $newEncodedPassword): void
    {
        if (!$user instanceof User) {
            throw new UnsupportedUserException(sprintf('Instances of "%s" are not supported.', \get_class($user)));
        }

        $user->setPassword($newEncodedPassword);
        $this->_em->persist($user);
        $this->_em->flush();
    }

    public function getTourists()
    {
        return $this->createQueryBuilder('tourists')
            ->select('tourists.id', 'tourists.userID', 'tourists.name')
            
            ->andWhere('tourists.roles LIKE :touristRole')
            ->setParameter('touristRole', '%'.'tourist'.'%')
            
            ->groupBy('tourists.id')
            
            ->getQuery()
            ->getResult();
    }

    public function getUser($userID)
    {
        return $this->createQueryBuilder('user')
            ->andWhere('user.userID =:userID')
            ->setParameter('userID', $userID)
            ->getQuery()
            ->getOneOrNullResult();
    }

    public function getAllAdministrators()
    {
        $adminRole = "ROLE_ADMIN";

        return $this->createQueryBuilder('user')
            ->select('user.id', 'user.createDate', 'user.roles', 'user.userID', 'user.name', 'user.email', 'user.image')

            ->andWhere('user.roles LIKE :roles')
            ->setParameter('roles', '%"'.$adminRole.'"%')

            ->getQuery()
            ->getResult();
    }
}
