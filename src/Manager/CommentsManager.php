<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\CommentsEntity;
use App\Entity\EventEntity;
use App\Entity\RegionsEntity;
use App\Entity\User;
use App\Repository\CommentsEntityRepository;
use App\Request\CommentCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class CommentsManager
{
    private $autoMapping;
    private $entityManager;
    private $commentsEntityRepository;
    private $touristsManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                CommentsEntityRepository $commentsEntityRepository, TouristsManager $touristsManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->commentsEntityRepository = $commentsEntityRepository;
        $this->touristsManager = $touristsManager;
    }

    public function commentCreate(CommentCreateRequest $request)
    {
        if ($request->region)
        {
            $region = $this->entityManager->getRepository(RegionsEntity::class)->find($request->region);
            $request->setRegion($region);
        }

        if ($request->event)
        {
            $event = $this->entityManager->getRepository(EventEntity::class)->find($request->event);
            $request->setEvent($event);
        }

        $user = $this->touristsManager->getTouristByUserID($request->user);
        $request->setUser($user);

        $commentCreate = $this->autoMapping->map(CommentCreateRequest::class, CommentsEntity::class, $request);

        $commentCreate->setDate($request->getDate());

        $this->entityManager->persist($commentCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $commentCreate;
    }

    public function getCommentsByID($id)
    {
        return $this->commentsEntityRepository->getCommentsByID($id);
    }

    public function commentsNumber($id)
    {
        return $this->commentsEntityRepository->commentsNumber($id);
    }

    public function eventCommentsNumber($id)
    {
        return $this->commentsEntityRepository->eventCommentsNumber($id);
    }

    public function getEventCommentsByID($id)
    {
        return $this->commentsEntityRepository->getEventCommentsByID($id);
    }

    public function getAllCommentsNumber()
    {
        return count($this->commentsEntityRepository->findAll());
    }
}