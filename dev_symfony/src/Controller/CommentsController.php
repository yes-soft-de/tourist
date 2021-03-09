<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CommentCreateRequest;
use App\Service\CommentsService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class CommentsController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $commentsService;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, AutoMapping $autoMapping, CommentsService $commentsService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->commentsService = $commentsService;
        $this->validator = $validator;
    }

    /**
     * @Route("/comment", name="createComment", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function createComment(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,CommentCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->commentsService->commentCreate($request);

        return $this->response($response, self::CREATE);
    }
}
