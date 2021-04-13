<?php


namespace App\Controller;


use App\Entity\AcceptedOrderEntity;
use App\Entity\CommentsEntity;
use App\Entity\EventEntity;
use App\Entity\GuidEntity;
use App\Entity\ImagesEntity;
use App\Entity\PaymentEntity;
use App\Entity\RatingsEntity;
use App\Entity\RegionsEntity;
use App\Entity\SettingEntity;
use App\Entity\TouristOrderEntity;
use App\Entity\User;

use Symfony\Component\Routing\Annotation\Route;

class EraseController extends BaseController
{
    /**
     * @Route("eraseall", name="deleteAllData", methods={"DELETE"})
     */
    public function eraseAllData()
    {
        try
        {
            $em = $this->getDoctrine()->getManager();

             $em->getRepository(AcceptedOrderEntity::class)->createQueryBuilder('acceptedOrderEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(CommentsEntity::class)->createQueryBuilder('CommentsEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(EventEntity::class)->createQueryBuilder('EventEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(GuidEntity::class)->createQueryBuilder('GuidEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(PaymentEntity::class)->createQueryBuilder('PaymentEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(ImagesEntity::class)->createQueryBuilder('ImagesEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(RatingsEntity::class)->createQueryBuilder('RatingsEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(RegionsEntity::class)->createQueryBuilder('RegionsEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(SettingEntity::class)->createQueryBuilder('SettingEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(TouristOrderEntity::class)->createQueryBuilder('TouristOrderEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(User::class)->createQueryBuilder('User')
                ->delete()
                ->getQuery()
                ->execute();
        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("", self::DELETE);
    }

    // Delete all users and related data
    /**
     * @Route("eraseallusers", name="deleteAllUsers", methods={"DELETE"})
     */
    public function eraseAllData2()
    {
        try
        {
            $em = $this->getDoctrine()->getManager();

            $em->getRepository(AcceptedOrderEntity::class)->createQueryBuilder('acceptedOrderEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(RatingsEntity::class)->createQueryBuilder('RatingsEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(CommentsEntity::class)->createQueryBuilder('CommentsEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(GuidEntity::class)->createQueryBuilder('GuidEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(TouristOrderEntity::class)->createQueryBuilder('TouristOrderEntity')
                ->delete()
                ->getQuery()
                ->execute();

            $em->getRepository(User::class)->createQueryBuilder('User')
                ->delete()
                ->getQuery()
                ->execute();
        }
        catch (\Exception $ex)
        {
            return $this->json($ex);
        }

        return $this->response("All users and related data were being deleted", self::DELETE);
    }
}