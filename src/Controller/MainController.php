<?php


namespace App\Controller;


use App\AutoMapping;
use App\Service\MainService;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class MainController extends BaseController
{
    private $autoMapping;
    private $mainService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, MainService $mainService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->mainService = $mainService;
    }

    /**
     * @Route("statistics", name="getStatistics", methods={"GET"})
     */
    public function getStatistics()
    {
        $result = $this->mainService->getStatistics();

        return $this->response($result, self::FETCH);
    }

}