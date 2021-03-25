<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Repository\AcceptedOrderEntityRepository;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\AcceptedOrderUpdateRequest;
use App\Request\TouristOrderUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class AcceptedOrderManager
{
    private $autoMapping;
    private $entityManager;
    private $acceptedOrderEntityRepository;
    private $touristOrderManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, TouristOrderManager $touristOrderManager,
                                AcceptedOrderEntityRepository $acceptedOrderEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->acceptedOrderEntityRepository = $acceptedOrderEntityRepository;
        $this->touristOrderManager = $touristOrderManager;
    }

    public function acceptOrderCreate(AcceptedOrderCreateRequest $request)
    {
        $create = $this->autoMapping->map(AcceptedOrderCreateRequest::class, AcceptedOrderEntity::class, $request);

        $create->setDate($request->getDate());
        // $create->setStatus('pending');

        $this->entityManager->persist($create);
        $this->entityManager->flush();
        $this->entityManager->clear();

        $order = $this->touristOrderManager->getOrderByID($request->getOrderID());
        
        if($order)
        {
            $order[0]->setStatus("done");

            $this->entityManager->flush();
            $this->entityManager->clear();
        }

        return $create;
    }

    // Get all pending accepted orders of tourist
    public function getAcceptedOrder($userID)
    {
        return $this->acceptedOrderEntityRepository->getAcceptedOrder($userID);
    }

    // Get all accepted orders of tourist whatever status is
    public function getAllAcceptedOrdersOfTourist($touristID)
    {
        return $this->acceptedOrderEntityRepository->getAllAcceptedOrdersOfTourist($touristID);
    }

    public function getAcceptcdOrdersByGuide($guideID)
    {
        return $this->acceptedOrderEntityRepository->getAcceptcdOrdersByGuide($guideID);
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