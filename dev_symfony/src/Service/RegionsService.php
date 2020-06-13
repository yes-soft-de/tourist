<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\RegionsEntity;
use App\Manager\RegionsManager;
use App\Request\RegionCreateRequest;
use App\Response\RegionCreateResponse;
use App\Response\RegionsResponse;

class RegionsService
{
    private $regionsManager;
    private $autoMapping;

    public function __construct(AutoMapping $autoMapping, RegionsManager $regionsManager)
    {
        $this->regionsManager = $regionsManager;
        $this->autoMapping = $autoMapping;
    }

    public function regionCreate(RegionCreateRequest $request)
    {
        $regionCreate = $this->regionsManager->regionCreate($request);

        $response = $this->autoMapping->map(RegionsEntity::class,RegionCreateResponse::class, $regionCreate);

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