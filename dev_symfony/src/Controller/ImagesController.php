<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ImageCreateRequest;
use App\Service\ImageService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class ImagesController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $imageService;
    private $validator;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ImageService $imageService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->imageService = $imageService;
        $this->validator = $validator;
    }

    /**
     * @Route("/image", name="saveRegionImages", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function saveImages(Request $request)
    {

        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,ImageCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->imageService->imageCreate($request);

        return $this->response($response, self::CREATE);
    }
}
