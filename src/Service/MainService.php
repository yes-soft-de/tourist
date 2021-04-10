<?php


namespace App\Service;


use App\AutoMapping;
use App\Manager\MainManager;
use App\Response\GetStatisticsResponse;

class MainService
{
    private $autoMapping;
    private $mainManager;

    public function __construct(AutoMapping $autoMapping, MainManager $mainManager)
    {
        $this->autoMapping = $autoMapping;
        $this->mainManager = $mainManager;
    }

    public function getStatistics()
    {
        $results = $this->mainManager->getStatistics();

        return $this->autoMapping->map('array', GetStatisticsResponse::class, $results);
    }

}