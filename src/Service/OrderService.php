<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Entity\TouristOrderEntity;
use App\Manager\AcceptedOrderManager;
use App\Manager\TouristOrderManager;
use App\Repository\AcceptedOrderCreateResponse;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\AcceptedOrderUpdateRequest;
use App\Request\TouristOrderCreateRequest;
use App\Request\TouristOrderUpdateRequest;
use App\Response\AcceptedOrderResponse;
use App\Response\AcceptedOrderUpdateResponse;
use App\Response\OrderByGuidCityAndLanguageResponse;
use App\Response\TouristOrderCreateResponse;

class OrderService
{
    private $autoMapping;
    private $touristOrderManager;
    private $acceptedOrderManager;

    public function __construct(AutoMapping $autoMapping, TouristOrderManager $touristOrderManager, AcceptedOrderManager $acceptedOrderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->touristOrderManager = $touristOrderManager;
        $this->acceptedOrderManager = $acceptedOrderManager;
    }

    public function createOrder(TouristOrderCreateRequest $request)
    {
        $orderCreate = $this->touristOrderManager->createOrder($request);

        $response = $this->autoMapping->map(TouristOrderEntity::class,TouristOrderCreateResponse::class, $orderCreate);

        return $response;
    }

    public function updateOrder(TouristOrderUpdateRequest $request)
    {
        $orderUpdate = $this->touristOrderManager->updateOrder($request);

        $response = $this->autoMapping->map(TouristOrderEntity::class,TouristOrderUpdateRequest::class, $orderUpdate);

        return $response;
    }

    public function getOrderByTourist($touristID)
    {
        $ordersResponse = [];
        $orders = $this->touristOrderManager->getOrderByTourist($touristID);
        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', TouristOrderCreateResponse::class, $order);
        }

        return $ordersResponse;
    }

    public function getOrderByGuidCityAndLanguage($guidUserID)
    {
        $ordersResponse = [];
        $orders = $this->touristOrderManager->getOrderByGuidCityAndLanguage($guidUserID);
        //dd($orders);
        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', OrderByGuidCityAndLanguageResponse::class, $order);
        }

        return $ordersResponse;
    }

    public function acceptOrderCreate(AcceptedOrderCreateRequest $request)
    {
        $create = $this->acceptedOrderManager->acceptOrderCreate($request);

        $response = $this->autoMapping->map(AcceptedOrderEntity::class,AcceptedOrderCreateResponse::class, $create);

        return $response;
    }

    public function getAcceptedOrder($userID)
    {
        $ordersResponse = [];
        $orders = $this->acceptedOrderManager->getAcceptedOrder($userID);
        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', AcceptedOrderResponse::class, $order);
        }

        return $ordersResponse;
    }

    public function acceptedOrderUpdate(AcceptedOrderUpdateRequest $request)
    {
        $orderUpdate = $this->acceptedOrderManager->acceptedOrderUpdate($request);

        $response = $this->autoMapping->map(AcceptedOrderEntity::class,AcceptedOrderUpdateResponse::class, $orderUpdate);

        return $response;
    }

    public function getOrderByGuid($guidUserID)
    {
        $ordersResponse = [];
        $orders = $this->touristOrderManager->getOrderByGuid($guidUserID);
        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', TouristOrderCreateResponse::class, $order);
        }

        return $ordersResponse;
    }
}