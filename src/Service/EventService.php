<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\EventEntity;
use App\Manager\CommentsManager;
use App\Manager\EventManager;
use App\Manager\ImageManager;
use App\Request\EventCreateRequest;
use App\Request\EventUpdateRequest;
use App\Response\EventCreateResponse;
use App\Response\EventsResponse;
use App\Response\GetCommentsByIdResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class EventService
{
    private $autoMapping;
    private $eventManager;
    private $imageManager;
    private $commentsManager;
    private $params;
    private $guideService;

    public function __construct(AutoMapping $autoMapping, EventManager $eventManager, ImageManager $imageManager, CommentsManager $commentsManager, 
    ParameterBagInterface $params, GuidService $guideService)
    {
        $this->autoMapping = $autoMapping;
        $this->eventManager = $eventManager;
        $this->imageManager = $imageManager;
        $this->commentsManager = $commentsManager;
        $this->guideService = $guideService;
        $this->params = $params->get('upload_base_url') . '/';
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
            if ($images) {
            $event['imagesURL'] = $images[0]['path'];
            $event['images'] = $this->params.$images[0]['path'];
            $event['baseURL'] = $this->params;
            }
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
        if ($eventImages) {
        $images['imageURL'] = $images[0]['path'];
        $images['image'] = $this->params.$images[0]['path'];
        $images['baseURL'] = $this->params;
        $response->images = $images;
        }
        //get comments
        $commentsResponse= [];
        $comments = $this->commentsManager->getEventCommentsByID($id);

        $response->setCommentsNumber(count($comments));
        foreach ($comments as $comment)
        {
            // Check if the user who post the comment is Guide,
            // then we have to get his name from the Guide table
            if($comment['roles'][0] == "guid")
            {
                $guideResult = $this->guideService->getguideByUserID($comment['userID']);
                
                if($guideResult)
                {
                    $comment['userName'] = $guideResult->name;

                    $comment['userImage'] = $guideResult->image;
                }
            }
            else
            {
                $comment['userImage'] = $this->params . $comment['image'];
            }

            $commentsResponse[] = $this->autoMapping->map('array', GetCommentsByIdResponse::class, $comment);
        }
        if ($commentsResponse) 
        {
        //add comments to response
            $response->setComments($commentsResponse);
        }

        return $response;
    }

    public function eventCommentsCount($id)
    {
        return $this->commentsManager->eventCommentsNumber($id);
    }

    public function eventUpdate(EventUpdateRequest $request)
    {
        $item = $this->eventManager->eventUpdate($request);

        return $this->autoMapping->map(EventEntity::class, EventCreateResponse::class, $item);
    }

    public function delete($id)
    {
        $eventResult = $this->eventManager->delete($id);

        return $this->autoMapping->map(EventEntity::class, EventsResponse::class, $eventResult);
    }

}