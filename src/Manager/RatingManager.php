<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\RatingsEntity;
use App\Entity\RegionsEntity;
use App\Entity\User;
use App\Repository\RatingsEntityRepository;
use App\Repository\UserRepository;
use App\Request\RatingCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class RatingManager
{
    private $autoMapping;
    private $entityManager;
    private $ratingsEntityRepository;
    private $touristsManager;
    private $userRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RatingsEntityRepository $ratingsEntityRepository,
                                    TouristsManager $touristsManager, UserRepository $userRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->ratingsEntityRepository = $ratingsEntityRepository;
        $this->touristsManager = $touristsManager;
        $this->userRepository = $userRepository;
    }

    public function ratingCreate(RatingCreateRequest $request)
    {
        if ($request->region)
        {
            $region = $this->entityManager->getRepository(RegionsEntity::class)->find($request->region);
            $request->setRegion($region);
        }

        if ($request->guid)
        {
            $guid = $this->userRepository->getUser($request->guid);
            $request->setGuid($guid);
        }

        $user = $this->touristsManager->getTouristByUserID($request->user);
        $request->setUser($user);

        $ratingCreate = $this->autoMapping->map(RatingCreateRequest::class, RatingsEntity::class, $request);

        $this->entityManager->persist($ratingCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $ratingCreate;
    }

    public function getRegionRatingByID($id)
    {
        return $this->ratingsEntityRepository->ratingRegionCalculate($id);
    }

    public function getGuidRatingByID($id)
    {
        return $this->ratingsEntityRepository->ratingGuidCalculate($id);
    }

    public function getRatingsByRegion($id)
    {
        $ratings = $this->ratingsEntityRepository->getRatingsByRegion($id);

        foreach($ratings as $rating)
        {
            $this->entityManager->remove($rating);
            $this->entityManager->flush();
        }

        return $ratings;
    }

    public function getRatingsCount()
    {
        return count($this->ratingsEntityRepository->findAll());
    }

    public function getRatingByUserAndRegion($id, $userID)
    {
        return $this->ratingsEntityRepository->getRatingByUserAndRegion($id, $userID);
    }
}