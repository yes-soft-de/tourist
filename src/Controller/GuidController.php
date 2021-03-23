<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\GuidProfileUpdateRequest;
use App\Request\guidByAdminUpdateRequest;
use App\Request\GuidesFilterRequest;
use App\Request\GuidRegisterRequest;
use App\Service\GuidService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class GuidController extends BaseController
{
    private $autoMapping;
    private $guidService;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, AutoMapping $autoMapping,
                                GuidService $guidService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->guidService = $guidService;
        $this->validator = $validator;
    }

    /**
     * @Route("/guide", name="guidRegister", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function guidRegister(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,GuidRegisterRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->guidService->guidRegister($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/guide", name="guidProfileUpdate", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function guidProfileUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,GuidProfileUpdateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $response = $this->guidService->guidProfileUpdate($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @IsGranted("ROLE_ADMIN", message="Access denied")
     * @Route("/guidbyadminupdate", name="guidByAdminUpdate", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function guidByAdminUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, guidByAdminUpdateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }
        $response = $this->guidService->guidByAdminUpdate($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/guide/{id}", name="guidByRegion", methods={"GET"})
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
     * @Route("/guide", name="guidByPlaceId", methods={"GET"})
     * @param Request $request
     * @return JsonResponse
     */
    public function guidByPlaceId(Request $request)
    { 
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,GuidProfileUpdateRequest::class,(object)$data);
       
        $response = $this->guidService->guidByPlaceId($request->placeId);
       
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

    /**
     * @Route("/guidesfilter", name="filterGuides", methods={"POST"})
     * @return JsonResponse
     */
    public function filterGuides(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, GuidesFilterRequest::class, (object)$data);

        $response = $this->guidService->filterGuides($request);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/guidebyuseriD/{userId}", name="guideByUserId", methods={"GET"})
     * @return JsonResponse
     */
    
    public function getguideByUserID($userId)
    {
        $response = $this->guidService->getguideByUserID($userId);

        return $this->response($response, self::FETCH);
    }

    /**
     * @Route("/guidebyid/{id}", name="guideById", methods={"GET"})
     * @return JsonResponse
     */
    
    public function guideById($id)
    {
        $response = $this->guidService->guideById($id);

        return $this->response($response, self::FETCH);
    }
}
