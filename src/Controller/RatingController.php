<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\RatingCreateRequest;
use App\Service\RatingService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class RatingController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $ratingService;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, AutoMapping $autoMapping, RatingService $ratingService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->ratingService = $ratingService;
        $this->validator = $validator;
    }

    /**
     * @Route("/rating", name="ratingCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function ratingCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,RatingCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->ratingService->ratingCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/deleteratingsbyregion/{id}", name="deleteRegionRatings", methods={"DELETE"})
     * @return JsonResponse
     */
    public function deleteRegionRatings($id)
    {
        $response = $this->ratingService->deleteRegionRatings($id);

        return $this->response($response, self::DELETE);
    }
}
