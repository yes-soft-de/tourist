<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\EventEntity;
use App\Manager\CommentsManager;
use App\Manager\EventManager;
use App\Manager\ImageManager;
use App\Request\EventCreateRequest;
use App\Response\EventCreateResponse;
use App\Response\EventsResponse;
use App\Response\GetCommentsByIdResponse;

class EventService
{

    private $autoMapping;
    private $eventManager;
    private $imageManager;
    private $commentsManager;

    public function __construct(AutoMapping $autoMapping, EventManager $eventManager, ImageManager $imageManager, CommentsManager $commentsManager)
    {
        $this->autoMapping = $autoMapping;
        $this->eventManager = $eventManager;
        $this->imageManager = $imageManager;
        $this->commentsManager = $commentsManager;
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

            //count comment for each event
            $commentsCount = $this->eventCommentsCount($event['id']);
            $event['commentNumber'] = $commentsCount[1];
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

        //get comments
        $commentsResponse= [];
        $comments = $this->commentsManager->getEventCommentsByID($id);

        foreach ($comments as $comment)
        {
            $commentsResponse[] = $this->autoMapping->map('array', GetCommentsByIdResponse::class, $comment);
        }

        //add comments to response
        $response->setComments($commentsResponse);

        return $response;
    }

    public function eventCommentsCount($id)
    {
        return $this->commentsManager->eventCommentsNumber($id);
    }
}