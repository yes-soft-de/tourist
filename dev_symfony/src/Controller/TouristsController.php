<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\TouristRegisterRequest;
use App\Request\TouristUpdateRequest;
use App\Service\TouristsService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class TouristsController extends BaseController
{
    private $autoMapping;
    private $touristsService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping,
                                TouristsService $touristsService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->touristsService = $touristsService;
    }

    /**
     * @Route("/tourist", name="touristsRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function touristsRegister(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,TouristRegisterRequest::class,(object)$data);

        $response = $this->touristsService->touristRegister($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/tourist", name="touristsUpdate", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function touristsUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,TouristUpdateRequest::class,(object)$data);

        $response = $this->touristsService->touristUpdate($request);

        return $this->response($response, self::UPDATE);
    }
}
