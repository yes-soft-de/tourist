<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\GuidEntity;
use App\Entity\User;
use App\Manager\GuidManager;
use App\Manager\ImageManager;
use App\Manager\RatingManager;
use App\Request\GuidProfileUpdateRequest;
use App\Request\GuidRegisterRequest;
use App\Response\GuidByRegionResponse;
use App\Response\GuidesResponse;
use App\Response\GuidProfileUpdateResponse;
use App\Response\GuidRegisterResponse;
class GuidService
{
    private $autoMapping;
    private $guidManager;
    private $imageManager;
    private $ratingManager;

    public function __construct(AutoMapping $autoMapping, GuidManager $guidManager, ImageManager $imageManager, RatingManager $ratingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->guidManager = $guidManager;
        $this->imageManager = $imageManager;
        $this->ratingManager = $ratingManager;
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

    public function getGuidByRegion($regionID)
    {
        $guidesResponse = [];
        $guides = $this->guidManager->getGuidByRegion($regionID);
        foreach ($guides as $guid)
        {
            $guidesResponse[] = $this->autoMapping->map('array', GuidByRegionResponse::class, $guid);
        }
        //dd($guidesResponse);
        return $guidesResponse;
    }

    public function getGuides()
    {
        $guidesResponse = [];
        $guides = $this->guidManager->getGuides();

        foreach ($guides as $guid)
        {
            //rating
            $ratingGuidCalculate = $this->ratingManager->getGuidRatingByID($guid['user']);
            $guidRate = $ratingGuidCalculate[1];
            $guid['rating'] = $guidRate;
            //
            $guidesResponse[] = $this->autoMapping->map('array', GuidesResponse::class, $guid);
        }

        return $guidesResponse;
    }
}