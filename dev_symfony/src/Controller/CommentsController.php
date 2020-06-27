<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\CommentCreateRequest;
use App\Service\CommentsService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class CommentsController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $commentsService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, CommentsService $commentsService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->commentsService = $commentsService;
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

        $response = $this->commentsService->commentCreate($request);

        return $this->response($response, self::CREATE);
    }
}
