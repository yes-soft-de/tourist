<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\ImagesEntity;
use App\Entity\RegionsEntity;
use App\Manager\CommentsManager;
use App\Manager\ImageManager;
use App\Manager\RatingManager;
use App\Manager\RegionsManager;
use App\Request\RatingCreateRequest;
use App\Request\RegionCreateRequest;
use App\Request\RegionImageCreateRequest;
use App\Response\GetCommentsByIdResponse;
use App\Response\ImagesPathsResponse;
use App\Response\RegionCreateResponse;
use App\Response\RegionImageCreateResponse;
use App\Response\RegionResponse;
use App\Response\RegionsResponse;

class RegionsService
{
    private $regionsManager;
    private $autoMapping;
    private $imageManager;
    private $ratingManager;
    private $commentsManager;

    public function __construct(AutoMapping $autoMapping, RegionsManager $regionsManager, ImageManager $imageManager, RatingManager $ratingManager,
                                CommentsManager $commentsManager)
    {
        $this->regionsManager = $regionsManager;
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
        $this->ratingManager = $ratingManager;
        $this->commentsManager = $commentsManager;
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
        $response = $this->autoMapping->map('array', RegionResponse::class, $result[0]);

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

        //add comments to response
        $response->setComments($commentsResponse);
        //add images to response
        $response->setpaths($imagesResponse);
        //add rating to response
        $response->setRatingAverage($rate);

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
}