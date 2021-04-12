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
use App\Request\RegionUpdateRequest;
use App\Request\RegionCreateRequest;
use App\Request\ImageCreateRequest;
use App\Response\GetCommentsByIdResponse;
use App\Response\GuidByRegionResponse;
use App\Response\ImagesPathsResponse;
use App\Response\RegionCreateResponse;
use App\Response\ImageCreateResponse;
use App\Response\RegionResponse;
use App\Response\RegionsResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
class RegionsService
{
    private $regionsManager;
    private $autoMapping;
    private $imageManager;
    private $ratingManager;
    private $commentsManager;
    private $guidService;
    private $params;

    public function __construct(AutoMapping $autoMapping, RegionsManager $regionsManager, ImageManager $imageManager, RatingManager $ratingManager,
                                CommentsManager $commentsManager, ParameterBagInterface $params, GuidService $guideService)
    {
        $this->regionsManager = $regionsManager;
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
        $this->ratingManager = $ratingManager;
        $this->commentsManager = $commentsManager;
        $this->guidService = $guideService;
        $this->params = $params->get('upload_base_url') . '/';
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
                $image['pathURL'] = $image['path'];
                $image['path'] = $this->params.$image['path'];
                $image['baseURL'] = $this->params;
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
            // Check if the user who post the comment is Guide,
            // then we have to get his name from the Guide table
            if($comment['roles'][0] == "guid")
            {
                $guideResult = $this->guidService->getguideByUserID($comment['userID']);
                
                if($guideResult)
                {
                    $comment['userName'] = $guideResult->name;
                }
            }

            $commentsResponse[] = $this->autoMapping->map('array', GetCommentsByIdResponse::class, $comment);
        }

        //get images
        $imagesResponse = [];
        $images = $this->getRegionImages($id);
        foreach ($images as $image)
        {
            $image['pathURL'] = $image['path'];
            $image['path'] = $this->params.$image['path'];
            $image['baseURL'] = $this->params;
            $imagesResponse[] = $this->autoMapping->map('array', ImagesPathsResponse::class, $image);
        }

        //get rating
        $ratingRegionCalculate = $this->ratingRegionCalculate($id);
        $rate = $ratingRegionCalculate[1];

        //get guides region
        $guidesResponse = [];
        $guides = $this->guidService->getGuidesByPlaceId($result['placeId']);
        if ($guides) {
            foreach ($guides as $guid)
            {
                //rating
                $ratingGuidCalculate = $this->ratingManager->getGuidRatingByID($guid['user']);
                $guidRate = $ratingGuidCalculate[1];
                $guid['rating'] = $guidRate;
                //
                $guidesResponse[] = $this->autoMapping->map('array', GuidByRegionResponse::class, $guid);
            }
        }
        if($commentsResponse) {
        //add comments to response
        $response->setComments($commentsResponse);
        }
        if($imagesResponse) {
        //add images to response
        $response->setRegionImage($imagesResponse);
        }
        if($rate) {
        //add rating to response
        $response->setRatingAverage($rate);
        }
        if($guidesResponse) {
        //add guides to response
        $response->setGuides($guidesResponse);
        }
        return $response;
    }
    public function getRegionByPlaceID($placeId)
    {
        //get region
        $result = $this->regionsManager->getRegionByPlaceID($placeId);
        $response = $this->autoMapping->map('array', RegionResponse::class, $result);

        //get comments
        $commentsResponse= [];
        if ($result) 
        {
            $comments = $this->commentsManager->getCommentsByID($result['id']);

            foreach ($comments as $comment)
            {
                $commentsResponse[] = $this->autoMapping->map('array', GetCommentsByIdResponse::class, $comment);
            }
        }

        //get images
        $imagesResponse = [];
        if($result) {
            $images = $this->getRegionImages($result['id']);
            foreach ($images as $image)
            {
                
                $image['pathURL'] = $image['path'];
                $image['path'] = $this->params.$image['path'];
                $image['baseURL'] = $this->params;
                $imagesResponse[] = $this->autoMapping->map('array', ImagesPathsResponse::class, $image);
            }
        }
        $rate="";
        if($result) {
            //get rating
            $ratingRegionCalculate = $this->ratingRegionCalculate($result['id']);
            $rate = $ratingRegionCalculate[1];
        }
        //get guides region
        $guidesResponse = [];
        if($result) 
        {
            $guides = $this->guidService->getGuidesByPlaceId($result['placeId']);
            //dd($result);
            foreach ($guides as $guid)
            {
                //rating
                $ratingGuidCalculate = $this->ratingManager->getGuidRatingByID($guid['user']);
                $guidRate = $ratingGuidCalculate[1];
                $guid['rating'] = $guidRate;
                //
                $guidesResponse[] = $this->autoMapping->map('array', GuidByRegionResponse::class, $guid);
            }
        }
         if($commentsResponse) {
            //add comments to response
            $response->setComments($commentsResponse);
         }
         if($imagesResponse) {
            //add images to response
            $response->setRegionImage($imagesResponse);
         }
         if($rate) {
            //add rating to response
            $response->setRatingAverage($rate);
         }
         if($guidesResponse) {
            //add guides to response
            $response->setGuides($guidesResponse);
         }

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
        // return $this->regionsManager->getGuidByRegion($id);
    }
    
    // public function getGuidesByPlaceID($placeID)
    // {
    //     return $this->regionsManager->guidByPlaceId($placeID);
    // }

    // public function getGuidImage($guidID)
    // {
    //     return $this->imageManager->getGuidImage($guidID);
    // }

    public function update(RegionUpdateRequest $request)
    {
        $item = $this->regionsManager->update($request);

        return $this->autoMapping->map(RegionsEntity::class,RegionCreateResponse::class, $item);
    }

    public function getRegionsByName($name)
    {
        $response = [];

        $results = $this->regionsManager->getRegionsByName($name);

        foreach ($results as $result)
        {
            //count comment for each region
            $commentsCount = $this->commentsCount($result['id']);
            $result['commentNumber'] = $commentsCount[1];

            //calculate rating
            $ratingRegionCalculate = $this->ratingRegionCalculate($result['id']);
            $result['ratingAverage'] = $ratingRegionCalculate[1];

            //get images
            $imagesResponse = [];
            $images = $this->getRegionImages($result['id']);
            foreach ($images as $image)
            {
                $image['pathURL'] = $image['path'];
                $image['path'] = $this->params.$image['path'];
                $image['baseURL'] = $this->params;
                $imagesResponse[] = $this->autoMapping->map('array', ImagesPathsResponse::class, $image);
            }
            $result['path'] = $imagesResponse;

            $response[] = $this->autoMapping->map('array', RegionsResponse::class, $result);
        }

        return $response;
    }

}