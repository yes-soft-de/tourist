<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\EventEntity;
use App\Manager\EventManager;
use App\Manager\ImageManager;
use App\Request\EventCreateRequest;
use App\Response\EventCreateResponse;
use App\Response\EventsResponse;

class EventService
{

    private $autoMapping;
    private $eventManager;
    private $imageManager;

    public function __construct(AutoMapping $autoMapping, EventManager $eventManager, ImageManager $imageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->eventManager = $eventManager;
        $this->imageManager = $imageManager;
    }

    public function eventCreate(EventCreateRequest $request)
    {
        $eventCreate = $this->eventManager->eventCreate($request);

        $response = $this->autoMapping->map(EventEntity::class,EventCreateResponse::class, $eventCreate);

        return $response;
    }

    public function getEvents()
    {
        $eventsResponse = [];
        $events = $this->eventManager->getEvents();

        foreach ($events as $event)
        {
            //images
            $eventImages = $this->imageManager->getEventImage($event['id']);
            $images = $eventImages;
            $event['images'] = $images;
            //
            $eventsResponse[] = $this->autoMapping->map('array', EventsResponse::class, $event);
        }

        return $eventsResponse;
    }

    public function getEventByID($id)
    {
        $result = $this->eventManager->getEventByID($id);
        $response = $this->autoMapping->map('array', EventsResponse::class, $result);

        //images
        $eventImages = $this->imageManager->getEventImage($id);
        $images = $eventImages;
        $response->images = $images;

        return $response;
    }
}