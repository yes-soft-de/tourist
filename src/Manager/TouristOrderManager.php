<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\TouristOrderEntity;
use App\Repository\GuidEntityRepository;
use App\Repository\TouristOrderEntityRepository;
use App\Request\TouristOrderCreateRequest;
use App\Request\TouristOrderUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Validator\Constraints\Date;

class TouristOrderManager
{
    private $autoMapping;
    private $entityManager;
    private $orderEntityRepository;
    private $guidEntityRepository;
    private $guideManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                TouristOrderEntityRepository $orderEntityRepository, GuidEntityRepository $guidEntityRepository,
                                 GuidManager $guideManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->orderEntityRepository = $orderEntityRepository;
        $this->guidEntityRepository = $guidEntityRepository;
        $this->guideManager = $guideManager;
    }

    public function createOrder(TouristOrderCreateRequest $request)
    {
        if($request->getCost() == null)
        {
            $request->setCost(0);
        }

        $creteOrder = $this->autoMapping->map(TouristOrderCreateRequest::class, TouristOrderEntity::class, $request);

        $creteOrder->setDate($request->getDate());
        $creteOrder->setArriveDate($request->getArriveDate());
        $creteOrder->setLeaveDate($request->getLeaveDate());

        //$creteOrder->setStatus('waitingPayment');

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

    // Get only accepted orders of a tourist
    public function getOrderByTourist($touristID)
    {
        return $this->orderEntityRepository->getOrderByTourist($touristID);
    }

    // Get all orders of a tourist either they are accepted or not
    public function getAllOrdersByTouristID($touristID)
    {
        return $this->orderEntityRepository->getAllOrdersByTouristID($touristID);
    }

    public function getOrderByGuidCityAndLanguage($guidUserID)
    {
        //get guid city and language
        $city_language = $this->guidEntityRepository->getGuidCityAndLanguage($guidUserID);
        
        if(isset($city_language))
        {
            //get tourist orders
            return $this->orderEntityRepository->getOrderByGuidCityAndLanguage($city_language['city'], $city_language['language']);
        }
    }

    //Get orders with undefined guidUserID
    public function getOrdersByGuideCityAndLanguage($guideID)
    {
        //get guide city and language
        $city_language = $this->guideManager->getCityAndLanguageOfGuide($guideID);
        
        return $this->orderEntityRepository->getOrdersByGuideCitiesAndLanguages($city_language['city'], $city_language['language']);
    }

    public function getOrderByGuid($guidUserID)
    {
        return $this->orderEntityRepository->getOrdersByGuidUserID($guidUserID);
    }

    public function getOrderByID($id)
    {
        return $this->orderEntityRepository->getOrderByID($id);
    }
}