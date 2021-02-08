<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\ImagesEntity;
use App\Entity\RegionsEntity;
use App\Manager\CommentsManager;
use App\Manager\GuidManager;
use App\Manager\ImageManager;
use App\Manager\RatingManager;
use App\Manager\RegionsManager;
use App\Request\RatingCreateRequest;
use App\Request\RegionCreateRequest;
use App\Request\ImageCreateRequest;
use App\Response\GetCommentsByIdResponse;
use App\Response\GuidByRegionResponse;
use App\Response\ImagesPathsResponse;
use App\Response\RegionCreateResponse;
use App\Response\ImageCreateResponse;
use App\Response\RegionResponse;
use App\Response\RegionsResponse;

class RegionsService
{
    private $regionsManager;
    private $autoMapping;
    private $imageManager;
    private $ratingManager;
    private $commentsManager;
    private $guidManager;

    public function __construct(AutoMapping $autoMapping, RegionsManager $regionsManager, ImageManager $imageManager, RatingManager $ratingManager,
                                CommentsManager $commentsManager, GuidManager $guidManager)
    {
        $this->regionsManager = $regionsManager;
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
        $this->ratingManager = $ratingManager;
        $this->commentsManager = $commentsManager;
        $this->guidManager = $guidManager;
    }

    public function regionCreate(RegionCreateRequest $request)
    {
        //save region
        $regionCreate = $this->regionsManager->regionCreate($request);

        $response = $this->autoMapping->map(RegionsEntity::class,RegionCreateResponse::class, $regionCreate);

        //save image
        $regionImage =  new ImageCreateRequest();
        $regionImage->path = $request->path;
        $regionImage->region = $response->id;

        $path = $this->imageManager->imageCreate($regionImage);
        $imagePathResponse = $this->autoMapping->map(ImagesEntity::class,ImageCreateResponse::class, $path);

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
            //count comment for each region
            $commentsCount = $this->commentsCount($result['id']);
            $result['commentNumber'] = $commentsCount[1];
            //

            //calculate rating
            $ratingRegionCalculate = $this->ratingRegionCalculate($result['id']);
            $result['ratingAverage'] = $ratingRegionCalculate[1];
            //

            //get images
            $imagesResponse = [];
            $images = $this->getRegionImages($result['id']);
            foreach ($images as $image)
            {
                $imagesResponse[] = $this->autoMapping->map('array', ImagesPathsResponse::class, $image);
            }
            $result['path'] = $imagesResponse;

            $response[] = $this->autoMapping->map('array',RegionsResponse::class, $result);
        }

        return $response;
    }

    public function getRegion($id)
    {
        //get region
        $result = $this->regionsManager->getRegion($id);
        $response = $this->autoMapping->map('array', RegionResponse::class, $result);

        //get comments
        $commentsResponse= [];
        $comments = $this->commentsManager->getCommentsByID($id);

        foreach ($comments as $comment)
        {
            $commentsResponse[] = $this->autoMapping->map('array', GetCommentsByIdResponse::class, $comment);
        }

        //get images
        $imagesResponse = [];
        $images = $this->getRegionImages($id);
        foreach ($images as $image)
        {
            $imagesResponse[] = $this->autoMapping->map('array', ImagesPathsResponse::class, $image);
        }

        //get rating
        $ratingRegionCalculate = $this->ratingRegionCalculate($id);
        $rate = $ratingRegionCalculate[1];

        //get guides region
        $guidesResponse = [];
        $guides = $this->getGuidByRegion($id);

        foreach ($guides as $guid)
        {
            //rating
            $ratingGuidCalculate = $this->ratingManager->getGuidRatingByID($guid['user']);
            $guidRate = $ratingGuidCalculate[1];
            $guid['rating'] = $guidRate;
            //
            $guidesResponse[] = $this->autoMapping->map('array', GuidByRegionResponse::class, $guid);
        }

        //add comments to response
        $response->setComments($commentsResponse);
        //add images to response
        $response->setRegionImage($imagesResponse);
        //add rating to response
        $response->setRatingAverage($rate);
        //add guides to response
        $response->setGuides($guidesResponse);

        return $response;
    }

    public function commentsCount($id)
    {
        return $this->commentsManager->commentsNumber($id);
    }

    public function ratingRegionCalculate($id)
    {
        return $this->ratingManager->getRegionRatingByID($id);
    }

    public function getRegionImages($id)
    {
        return $this->imageManager->getRegionImages($id);
    }
    
    public function getGuidByRegion($id)
    {
        return $this->guidManager->getGuidByRegion($id);
    }

    public function getGuidImage($guidID)
    {
        return $this->imageManager->getGuidImage($guidID);
    }
}