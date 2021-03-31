<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\AcceptedOrderUpdateRequest;
use App\Service\OrderService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class AcceptedOrderController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $orderService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, OrderService $orderService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->orderService = $orderService;
        $this->validator = $validator;
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

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

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
     * @Route("/acceptedorders/{touristID}", name="getAcceptedOrdersByTouristID", methods="GET")
     * @return JsonResponse
     */
    public function getAllAcceptedOrdersOfTourist($touristID)
    {
        $response = $this->orderService->getAllAcceptedOrdersOfTourist($touristID);

        return $this->response($response,self::FETCH);
    }
    
    /**
     * @Route("/acceptordersbyguide/{guideID}", name="getAcceptedOrderByGuideID", methods="GET")
     * @return JsonResponse
     */
    public function getAcceptedOrderByGuide($guideID)
    {
        $response = $this->orderService->getAcceptcdOrdersByGuide($guideID);

        return $this->response($response, self::FETCH);
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

    /**
     * @Route("/acceptedordersbystatus/{status}", name="getAllFinishedOrders", methods={"GET"})
     * @return JsonResponse
     */
    public function getAcceptedOrdersByStatus($status)
    {
        $response = $this->orderService->getAcceptedOrdersByStatus($status);

        return $this->response($response, self::UPDATE);
    }

}
