<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\EventEntity;
use App\Repository\EventEntityRepository;
use App\Request\EventCreateRequest;
use App\Request\EventUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class EventManager
{
    private $autoMapping;
    private $entityManager;
    private $eventEntityRepository;
    private $imageManager;
    private $commentManager;
    private $ratingManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, EventEntityRepository $eventEntityRepository,
     ImageManager $imageManager, CommentsManager $commentManager, RatingManager $ratingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->eventEntityRepository = $eventEntityRepository;
        $this->imageManager = $imageManager;
        $this->commentManager = $commentManager;
        $this->ratingManager = $ratingManager;
    }

    public function eventCreate(EventCreateRequest $request)
    {

        $eventCreate = $this->autoMapping->map(EventCreateRequest::class, EventEntity::class, $request);
        $eventCreate->setDate($request->getDate());

        $this->entityManager->persist($eventCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $eventCreate;
    }

    public function getEvents()
    {
        return $this->eventEntityRepository->getEvents();
    }

    public function getEventByID($id)
    {
        return $this->eventEntityRepository->getEventByID($id);
    }

    public function eventUpdate(EventUpdateRequest $request)
    {
        $entity = $this->eventEntityRepository->find($request->getId());

         if ($entity)
        {
            $item = $this->autoMapping->mapToObject(EventUpdateRequest::class,
            EventEntity::class, $request, $entity);

            $this->entityManager->flush();
            $this->entityManager->clear();
            return $item;
        }
    }

    public function delete($id)
    {
        $event = $this->eventEntityRepository->find($id);

        if($event)
        {
            //first, we have to delete the related image

            $image = $this->imageManager->getImageOfEvent($event->getId());

            if($image)
            {
                $this->entityManager->remove($image);
                $this->entityManager->flush();
            }

            //also, we have to delete the related comments

            $comments = $this->commentManager->getCommentsByEvent($event->getId());

            if(isset($comments))
            {
                foreach($comments as $comment)
                {
                    $this->entityManager->remove($comment);
                    $this->entityManager->flush();
                }
            }

            //now, we delete the region

            $this->entityManager->remove($event);
            $this->entityManager->flush();
        }

        return $event;
    }
}