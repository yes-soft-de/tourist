<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\GuidProfileUpdateRequest;
use App\Request\GuidRegisterRequest;
use App\Service\GuidService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class GuidController extends BaseController
{
    private $autoMapping;
    private $guidService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping,
                                GuidService $guidService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->guidService = $guidService;
    }

    /**
     * @Route("/guid", name="guidRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function guidRegister(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,GuidRegisterRequest::class,(object)$data);

        $response = $this->guidService->guidRegister($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/guid", name="guidProfileUpdate", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function guidProfileUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,GuidProfileUpdateRequest::class,(object)$data);

        $response = $this->guidService->guidProfileUpdate($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/guid/{id}", name="guidByRegion", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function guidByRegion(Request $request)
    {
        $response = $this->guidService->getGuidByRegion($request->get('id'));
        //dd($request->get('id'));
        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/guides", name="guides", methods={"GET"})
     * @return JsonResponse
     */
    public function guides()
    {
        $response = $this->guidService->getGuides();

        return $this->response($response,self::FETCH);
    }
}
