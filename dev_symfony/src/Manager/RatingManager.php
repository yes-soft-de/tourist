<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\RatingsEntity;
use App\Entity\RegionsEntity;
use App\Entity\User;
use App\Repository\RatingsEntityRepository;
use App\Request\RatingCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class RatingManager
{
    private $autoMapping;
    private $entityManager;
    private $ratingsEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RatingsEntityRepository $ratingsEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->ratingsEntityRepository = $ratingsEntityRepository;
    }

    public function ratingCreate(RatingCreateRequest $request)
    {

        if ($request->region)
        {
            $region = $this->entityManager->getRepository(RegionsEntity::class)->find($request->region);
            $request->setRegion($region);
        }

        $user = $this->entityManager->getRepository(User::class)->find($request->user);
        $request->setUser($user);

        $ratingCreate = $this->autoMapping->map(RatingCreateRequest::class, RatingsEntity::class, $request);

        $this->entityManager->persist($ratingCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $ratingCreate;
    }
}