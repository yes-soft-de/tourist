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

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, EventEntityRepository $eventEntityRepository,
     ImageManager $imageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->eventEntityRepository = $eventEntityRepository;
        $this->imageManager = $imageManager;
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
            //now, we have to delete the related image

            $image = $this->imageManager->getImageOfEvent($event->getId());

            if($image)
            {
                $this->entityManager->remove($image);
                $this->entityManager->flush();
            }

            $this->entityManager->remove($event);
            $this->entityManager->flush();
        }

        return $event;
    }
}