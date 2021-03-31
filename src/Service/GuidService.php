<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\GuidEntity;
use App\Entity\User;
use App\Manager\GuidManager;
use App\Manager\ImageManager;
use App\Manager\RatingManager;
use App\Request\GuidProfileUpdateRequest;
use App\Request\guidByAdminUpdateRequest;
use App\Request\GuidesFilterRequest;
use App\Request\GuidRegisterRequest;
use App\Response\GuidByRegionResponse;
use App\Response\GuideProfileGetResponse;
use App\Response\GuidesResponse;
use App\Response\GuidProfileUpdateResponse;
use App\Response\GuidRegisterResponse;
use App\Service\OrderService;

use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class GuidService
{
    private $autoMapping;
    private $guidManager;
    private $imageManager;
    private $ratingManager;
    private $params;
    private $orderService;

    public function __construct(AutoMapping $autoMapping, GuidManager $guidManager, ImageManager $imageManager, RatingManager $ratingManager, ParameterBagInterface $params, OrderService $orderService)
    {
        $this->autoMapping = $autoMapping;
        $this->guidManager = $guidManager;
        $this->imageManager = $imageManager;
        $this->ratingManager = $ratingManager;
        $this->orderService = $orderService;
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function guidRegister(GuidRegisterRequest $request)
    {
        $guidRegister = $this->guidManager->guidRegister($request);

        $response = $this->autoMapping->map(User::class,GuidRegisterResponse::class, $guidRegister);

        return $response;
    }

    public function guidProfileUpdate(GuidProfileUpdateRequest $request)
    {
        $guidProfileUpdate = $this->guidManager->updateGuidProfile($request);

        $response = $this->autoMapping->map(GuidEntity::class,GuidProfileUpdateResponse::class, $guidProfileUpdate);
        //dd($response->id);

        return $response;
    }

    public function guidByAdminUpdate(guidByAdminUpdateRequest $request)
    {
        $guidProfileUpdate = $this->guidManager->guidByAdminUpdate($request);

        $response = $this->autoMapping->map(GuidEntity::class,GuidProfileUpdateResponse::class, $guidProfileUpdate);
        //dd($response->id);

        return $response;
    }

    public function getGuidByRegion($regionID)
    {
        $guidesResponse = [];
        $guides = $this->guidManager->getGuidByRegion($regionID);
        if ($guides) {
        foreach ($guides as $guid)
        {
            $guid['imageURL'] = $guid['image'];
            $guid['image'] = $this->params.$guid['image'];
            $guid['baseURL'] = $this->params;

            $guidesResponse[] = $this->autoMapping->map('array', GuidByRegionResponse::class, $guid);
        }
    }
        //dd($guidesResponse);
        return $guidesResponse;
    }

    public function guidByPlaceId($placeId)
    {
        $guidesResponse = [];
        $guides = $this->guidManager->guidByPlaceId($placeId);
     
        foreach ($guides as $guid)
        {
            $guid['imageURL'] = $guid['image'];
            $guid['image'] = $this->params.$guid['image'];
            $guid['baseURL'] = $this->params;

            $guidesResponse[] = $this->autoMapping->map('array', GuidByRegionResponse::class, $guid);
        }
        return $guidesResponse;
    }

    public function getGuidesByPlaceId($placeId)
    {
        return $this->guidManager->guidByPlaceId($placeId);
    }

    public function getGuides()
    {
        $guidesResponse = [];
        $guidArray = [];
        $guides = $this->guidManager->getGuides();

        foreach ($guides as $guid)
        {
            //rating
            $ratingGuidCalculate = $this->ratingManager->getGuidRatingByID($guid['user']);
          
            $guidRate = $ratingGuidCalculate[1];
            $guid['rating'] = $guidRate;

            //-------> Start of editing
            $guidArray[] = $guid;
            //Sort the matrix in descending order by rating
            array_multisort(array_column($guidArray, 'rating'), SORT_DESC, $guidArray);
            //end of editing <-------

            // $guidesResponse[] = $this->autoMapping->map('array', GuidesResponse::class, $guid);
        }
        //-------> Start of editing
        foreach ($guidArray as $guidArr) 
        {
            foreach($guidArr['places'] as $place)
            {
                $guidArr['regions'][] = $this->guidManager->getRegionByPlaceID($place); 
            }
             
            $guidesResponse[] = $this->autoMapping->map('array', GuidesResponse::class, $guidArr);
        }
        //end of editing <-------
        
        return $guidesResponse;
    }

    public function filterGuides(GuidesFilterRequest $request)
    {
        $response = [];
        $language = $request->getLanguage();
        $city = $request->getCity();
        
        if($language != NULL && $city == NULL)
        {
            $guides = $this->guidManager->guidesByLanguage($language);
        }
        elseif($language == NULL && $city != NULL)
        {
            $guides = $this->guidManager->guidesByCity($city);
        }
        elseif($language != NULL && $city != NULL)
        {
            $guides = $this->guidManager->guidesByLanguageAndCity($language, $city);
        }
        
        foreach ($guides as $guide) 
        {
            foreach($guide['places'] as $place)
            {
                $guide['regions'][] = $this->guidManager->getRegionByPlaceID($place); 
            }

            $response[] = $this->autoMapping->map('array', GuidesResponse::class, $guide);
        }

        return $response;
    }

    public function getguideByUserID($userId)
    {
        $item = $this->guidManager->getguideByUserID($userId);

        if(isset($item['image']))
        {
            $item['imageURL'] = $item['image'];
            
            $item['image'] = $this->params.$item['image'];
        }

        $item['baseURL'] = $this->params;

        return $this->autoMapping->map('array', GuideProfileGetResponse::class, $item);
    }

    public function guideById($id)
    {
        $item = $this->guidManager->guideById($id);
        
        if($item) 
        {
            $item['imageURL'] = $item['image'];
            $item['image'] = $this->params.$item['image'];
            $item['baseURL'] = $this->params;
            $item['myOrders'] = $this->orderService->getOrderByGuid($item['userID']);

            //rating
            $ratingGuidCalculate = $this->ratingManager->getGuidRatingByID($item['user']);
          
            $guidRate = $ratingGuidCalculate[1];
            $item['rating'] = $guidRate;
        }
        
        return $this->autoMapping->map('array', GuidByRegionResponse::class, $item);
    }
}