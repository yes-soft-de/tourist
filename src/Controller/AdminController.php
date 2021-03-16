<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\AdminCreateRequest;
use App\Service\AdminService;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\IsGranted;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class AdminController extends BaseController
{
    private $autoMapping;
    private $validator;
    private $adminService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, ValidatorInterface $validator, 
    AdminService $adminService) 
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->validator = $validator;
        $this->adminService = $adminService;
    }

    /**
     * @Route("/createadmin", name="adminCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function adminCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, AdminCreateRequest::class, (object)$data);

        $violations = $this->validator->validate($request);
        
        if (\count($violations) > 0) 
        {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->adminService->adminCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @IsGranted("ROLE_SUPER_ADMIN", message="Access denied")
     * @Route("deleteadmin/{userID}", name="deleteAdmin", methods={"DELETE"})
     * @param $userID
     * @return JsonResponse
     */
    public function deleteAdmin($userID)
    {
        $result = $this->adminService->deleteAdmin($userID);

        return $this->response($result, self::DELETE);
    }

    /**
     * @IsGranted("ROLE_SUPER_ADMIN", message="Access denied")
     * @Route("getadministrators", name="getAllAdministrators", methods={"GET"})
     */
    public function getAllAdministrators()
    {
        $response = $this->adminService->getAllAdministrators();

        return $this->response($response,self::FETCH);
    }
}
