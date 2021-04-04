<?php


namespace App\Controller;


use App\AutoMapping;
use App\Entity\CommentEntity;
use App\Entity\ImageEntity;
use App\Entity\ServicesEntity;
use App\Entity\SettingEntity;
use App\Entity\StatusEntity;
use App\Entity\UserEntity;
use App\Entity\UserProfileEntity;
use App\Service\MainService;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class MainController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $mainService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator,
                                MainService $mainService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
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