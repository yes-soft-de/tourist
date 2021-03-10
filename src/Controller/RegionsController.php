<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\RegionCreateRequest;
use App\Service\RegionsService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class RegionsController extends BaseController
{

    private $serializer;
    private $regionsService;
    private $autoMapping;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, AutoMapping $autoMapping, RegionsService $regionsService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->regionsService = $regionsService;
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
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

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

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

    /**
     * @Route("/regionbyplaceid/{placeId}", name="getRegionByPlaceID", methods="GET")
     * @return JsonResponse
     */
    public function getRegionByPlaceID($placeId)
    {
        $response = $this->regionsService->getRegionByPlaceID($placeId);

        return $this->response($response,self::FETCH);
    }
}
