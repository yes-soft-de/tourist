<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Repository\AcceptedOrderEntityRepository;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\AcceptedOrderUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AcceptedOrderManager
{

    private $autoMapping;
    private $entityManager;
    private $acceptedOrderEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                AcceptedOrderEntityRepository $acceptedOrderEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->acceptedOrderEntityRepository = $acceptedOrderEntityRepository;
    }

    public function acceptOrderCreate(AcceptedOrderCreateRequest $request)
    {
        $create = $this->autoMapping->map(AcceptedOrderCreateRequest::class, AcceptedOrderEntity::class, $request);

        $create->setDate($request->getDate());
        $create->setStatus('pending');

        $this->entityManager->persist($create);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $create;
    }

    public function getAcceptedOrder($userID)
    {
        return $this->acceptedOrderEntityRepository->getAcceptedOrder($userID);
    }

    public function acceptedOrderUpdate(AcceptedOrderUpdateRequest $request)
    {
        $order = $this->acceptedOrderEntityRepository->find($request->id);

        if ($order)
        {
            $order = $this->autoMapping->mapToObject(AcceptedOrderUpdateRequest::class,
                AcceptedOrderEntity::class, $request, $order);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $order;
        }
    }
}