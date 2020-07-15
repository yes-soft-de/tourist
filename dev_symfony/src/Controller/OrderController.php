<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\TouristOrderCreateRequest;
use App\Request\TouristOrderUpdateRequest;
use App\Service\OrderService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class OrderController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $orderService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, OrderService $orderService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->orderService = $orderService;
    }

    /**
     * @Route("/order", name="orderCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function orderCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);
        //dd($data);
        $request = $this->autoMapping->map(stdClass::class,TouristOrderCreateRequest::class,(object)$data);

        $response = $this->orderService->createOrder($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/order", name="orderUpdate", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function orderUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,TouristOrderUpdateRequest::class,(object)$data);

        $response = $this->orderService->updateOrder($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/order/{id}", name="getOrderByTourist", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getOrderByTourist(Request $request)
    {
        $response = $this->orderService->getOrderByTourist($request->get('id'));

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/orderlookup/{id}", name="getOrderByGuidCityAndLanguage", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getOrderByGuidCityAndLanguage(Request $request)
    {
        $response = $this->orderService->getOrderByGuidCityAndLanguage($request->get('id'));

        return $this->response($response,self::FETCH);
    }
}
