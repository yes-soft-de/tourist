<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\TouristOrderCreateRequest;
use App\Request\TouristOrderUpdateRequest;
use App\Service\OrderService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class OrderController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $orderService;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, AutoMapping $autoMapping, OrderService $orderService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->orderService = $orderService;
        $this->validator = $validator;
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

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

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
     * @Route("/orders/{touristID}", name="getAllOrdersByTouristID", methods="GET")
     * @return JsonResponse
     */
    public function getAllOrdersByTouristID($touristID)
    {
        //Get all orders of a tourist either they are accepted or not
        $response = $this->orderService->getAllOrdersByTouristID($touristID);

        return $this->response($response, self::FETCH);
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

    /**
     * @Route("/ordersbycityandlanguage/{guideID}", name="getOrdersByGuideCityAndLanguage", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getOrdersByGuideCityAndLanguage($guideID)
    {
        $response = $this->orderService->getOrdersByGuideCityAndLanguage($guideID);

        return $this->response($response, self::FETCH);
    }

      /**
     * @Route("/guideorder/{id}", name="getOrderByGuid", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getOrderByGuid(Request $request)
    {
        $response = $this->orderService->getOrderByGuid($request->get('id'));

        return $this->response($response,self::FETCH);
    }
}
