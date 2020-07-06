<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ImageCreateRequest;
use App\Service\ImageService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class ImagesController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $imageService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ImageService $imageService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->imageService = $imageService;
    }

    /**
     * @Route("/regionimage", name="saveRegionImages", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function saveRegionImages(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,ImageCreateRequest::class,(object)$data);

        $response = $this->imageService->regionImageCreate($request);

        return $this->response($response, self::CREATE);
    }
}
