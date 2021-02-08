<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\EventEntity;
use App\Repository\EventEntityRepository;
use App\Request\EventCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class EventManager
{
    private $autoMapping;
    private $entityManager;
    private $eventEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, EventEntityRepository $eventEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->eventEntityRepository = $eventEntityRepository;
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
}