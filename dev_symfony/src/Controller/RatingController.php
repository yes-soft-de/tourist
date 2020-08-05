<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\RatingCreateRequest;
use App\Service\RatingService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class RatingController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $ratingService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, RatingService $ratingService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->ratingService = $ratingService;
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

        $response = $this->ratingService->ratingCreate($request);

        return $this->response($response, self::CREATE);
    }
}
