<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\TouristOrderEntity;
use App\Repository\GuidEntityRepository;
use App\Repository\TouristOrderEntityRepository;
use App\Request\TouristOrderCreateRequest;
use App\Request\TouristOrderUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class TouristOrderManager
{
    private $autoMapping;
    private $entityManager;
    private $orderEntityRepository;
    private $guidEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                TouristOrderEntityRepository $orderEntityRepository, GuidEntityRepository $guidEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderEntityRepository = $orderEntityRepository;
        $this->guidEntityRepository = $guidEntityRepository;
    }

    public function createOrder(TouristOrderCreateRequest $request)
    {
        $creteOrder = $this->autoMapping->map(TouristOrderCreateRequest::class, TouristOrderEntity::class, $request);

        $creteOrder->setDate($request->date);
        $creteOrder->setArriveDate($request->arriveDate);
        $creteOrder->setLeaveDate($request->leaveDate);
        $creteOrder->setStatus('waitingPayment');

        $this->entityManager->persist($creteOrder);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $creteOrder;
    }

    public function updateOrder(TouristOrderUpdateRequest $request)
    {
        $order = $this->orderEntityRepository->find($request->id);

        if ($order)
        {
            $order = $this->autoMapping->mapToObject(TouristOrderUpdateRequest::class,
                TouristOrderEntity::class, $request, $order);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $order;
        }
    }

    public function getOrderByTourist($touristID)
    {
        return $this->orderEntityRepository->getOrderByTourist($touristID);
    }

    public function getOrderByGuidCityAndLanguage($guidUserID)
    {
        //get guid city and language
        $city_language = $this->guidEntityRepository->getGuidCityAndLanguage($guidUserID);

        //get tourist orders
        return $this->orderEntityRepository->getOrderByGuidCityAndLanguage($city_language, $city_language);
    }
}