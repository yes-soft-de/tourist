<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\CommentsEntity;
use App\Manager\CommentsManager;
use App\Request\CommentCreateRequest;
use App\Response\CommentCreateResponse;

class CommentsService
{
    private $autoMapping;
    private $commentsManager;

    public function __construct(AutoMapping $autoMapping, CommentsManager $commentsManager)
    {
        $this->autoMapping = $autoMapping;
        $this->commentsManager = $commentsManager;
    }

    public function commentCreate(CommentCreateRequest $request)
    {
        //dd($request->user);
        $commentCreate = $this->commentsManager->commentCreate($request);

        $response = $this->autoMapping->map(CommentsEntity::class,CommentCreateResponse::class, $commentCreate);

        return $response;
    }
}