<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\RegionCreateRequest;
use App\Service\RegionsService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class RegionsController extends BaseController
{

    private $serializer;
    private $regionsService;
    private $autoMapping;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, RegionsService $regionsService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->regionsService = $regionsService;
        $this->autoMapping = $autoMapping;
    }

    /**
     * @Route("/regions", name="regions", methods="GET")
     */
    public function regions()
    {
        $response = $this->regionsService->getRegions();

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/region", name="regionCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function regionCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,RegionCreateRequest::class,(object)$data);

        $response = $this->regionsService->regionCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/region/{id}", name="getregion", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getRegion(Request $request)
    {
        $response = $this->regionsService->getRegion($request->get('id'));

        return $this->response($response,self::FETCH);
    }
}
