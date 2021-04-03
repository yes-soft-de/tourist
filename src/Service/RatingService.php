<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\RatingsEntity;
use App\Manager\RatingManager;
use App\Request\RatingCreateRequest;
use App\Response\RatingCreateResponse;

class RatingService
{
    private $autoMapping;
    private $ratingManager;

    public function __construct(AutoMapping $autoMapping, RatingManager $ratingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->ratingManager = $ratingManager;
    }

    public function ratingCreate(RatingCreateRequest $request)
    {
        $ratingCreate = $this->ratingManager->ratingCreate($request);

        $response = $this->autoMapping->map(RatingsEntity::class,RatingCreateResponse::class, $ratingCreate);

        return $response;
    }

    public function deleteRegionRatings($id)
    {
        $response = [];

        $ratings = $this->ratingManager->getRatingsByRegion($id);

        foreach($ratings as $rating)
        {
            $response[] = $this->autoMapping->map(RatingsEntity::class, RatingCreateResponse::class, $rating);
        }

        return $response;
    }
}