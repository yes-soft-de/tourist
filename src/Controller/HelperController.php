<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class HelperController extends BaseController
{
    private $params;

    public function __construct(SerializerInterface $serializer, ParameterBagInterface $params)
    {
        parent::__construct($serializer);
        $this->params = $params->get('MAP_KEY');
    }

    /**
     * @Route("/maphelper", name="mapHelper", methods="GET")
     * @return JsonResponse
     */
    public function mapHelper(): JsonResponse
    {
        $response = $this->params;

        return $this->response($response,self::FETCH);
    }
}
