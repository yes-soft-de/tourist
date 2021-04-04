<?php


namespace App\Manager;


use App\AutoMapping;

class MainManager
{
    private $autoMapping;
    private $touristManager;
    private $eventManager;
    private $acceptedOrderManager;
    private $regionManager;
    private $guideManager;
    private $commentManager;
    private $ratingManager;

    public function __construct(AutoMapping $autoMapping, RegionsManager $regionsManager, EventManager $eventManager,
     AcceptedOrderManager $acceptedOrderManager, GuidManager $guideManager, CommentsManager $commentManager, 
     TouristsManager $touristManager, RatingManager $ratingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->regionManager = $regionsManager;
        $this->eventManager = $eventManager;
        $this->acceptedOrderManager = $acceptedOrderManager;
        $this->guideManager = $guideManager;
        $this->commentManager = $commentManager;
        $this->touristManager = $touristManager;
        $this->ratingManager = $ratingManager;
    }

    public function getStatistics()
    {
        $response = [];
        
        $response['regions'] = count($this->regionManager->getRegions());

        $response['events'] = count($this->eventManager->getEvents());

        $response['completedOrders'] = count($this->acceptedOrderManager->getAcceptedOrdersByStatus("done"));

        $response['users']['guides'] = count($this->guideManager->getGuides());

        $response['users']['tourists'] = count($this->touristManager->getTourists());

        $response['comments'] = $this->commentManager->getAllCommentsNumber();

        $response['ratings'] = $this->ratingManager->getRatingsCount();

        return $response;
    }

}