<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\ImagesEntity;
use App\Entity\RegionsEntity;
use App\Manager\ImageManager;
use App\Manager\RatingManager;
use App\Manager\RegionsManager;
use App\Request\RatingCreateRequest;
use App\Request\RegionCreateRequest;
use App\Request\RegionImageCreateRequest;
use App\Response\RegionCreateResponse;
use App\Response\RegionImageCreateResponse;
use App\Response\RegionsResponse;

class RegionsService
{
    private $regionsManager;
    private $autoMapping;
    private $imageManager;
    /**
     * @var RatingManager
     */
    private $ratingManager;

    public function __construct(AutoMapping $autoMapping, RegionsManager $regionsManager, ImageManager $imageManager, RatingManager $ratingManager)
    {
        $this->regionsManager = $regionsManager;
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
        $this->ratingManager = $ratingManager;
    }

    public function regionCreate(RegionCreateRequest $request)
    {
        //save region
        $regionCreate = $this->regionsManager->regionCreate($request);

        $response = $this->autoMapping->map(RegionsEntity::class,RegionCreateResponse::class, $regionCreate);

        //save image
        $regionImage =  new RegionImageCreateRequest();
        $regionImage->path = $request->path;
        $regionImage->region = $response->id;

        $path = $this->imageManager->regionImageCreate($regionImage);
        $imagePathResponse = $this->autoMapping->map(ImagesEntity::class,RegionImageCreateResponse::class, $path);

        //save default rating
        $rating = new RatingCreateRequest();
        $rating->setUser(1);
        $rating->setRegion($response->id);
        $rating->setRate(0);

        $this->ratingManager->ratingCreate($rating);

        //add path to response
        $response->setPath($imagePathResponse->getPath());

        return $response;
    }

    public function getRegions()
    {
        $response = [];

        $results = $this->regionsManager->getRegions();

        foreach ($results as $result)
        {
            $response[] = $this->autoMapping->map('array',RegionsResponse::class, $result);
        }

        return $response;
    }
}