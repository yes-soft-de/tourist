<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\AcceptedOrderUpdateRequest;
use App\Service\OrderService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class AcceptedOrderController extends BaseController
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
     * @Route("/acceptorder", name="acceptorder", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function acceptOrder(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,AcceptedOrderCreateRequest::class,(object)$data);

        $response = $this->orderService->acceptOrderCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/acceptorder/{id}", name="getAcceptedOrderByTourist", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getAcceptedOrderByTourist(Request $request)
    {
        $response = $this->orderService->getAcceptedOrder($request->get('id'));

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/acceptorder", name="acceptOrderUpdate", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function acceptedOrderUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,AcceptedOrderUpdateRequest::class,(object)$data);

        $response = $this->orderService->acceptedOrderUpdate($request);

        return $this->response($response, self::UPDATE);
    }


}
