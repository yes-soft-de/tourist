<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\User;
use App\Manager\TouristsManager;
use App\Request\TouristRegisterRequest;
use App\Request\TouristRegisterResponse;
use App\Request\TouristUpdateRequest;
use App\Response\TouristUpdateResponse;

class TouristsService
{
    private $touristsManager;
    private $autoMapping;

    public function __construct(AutoMapping $autoMapping, TouristsManager $touristsManager)
    {
        $this->touristsManager = $touristsManager;
        $this->autoMapping = $autoMapping;
    }

    public function touristRegister(TouristRegisterRequest $request)
    {
        $touristRegister = $this->touristsManager->TouristRegister($request);

        $response = $this->autoMapping->map(User::class,TouristRegisterResponse::class, $touristRegister);

        return $response;
    }

    public function touristUpdate(TouristUpdateRequest $request)
    {
        $touristUpdate = $this->touristsManager->touristUpdate($request);

        $response = $this->autoMapping->map(User::class,TouristUpdateResponse::class, $touristUpdate);

        return $response;
    }
}