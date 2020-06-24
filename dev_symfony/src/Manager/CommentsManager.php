<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\CommentsEntity;
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

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                CommentsEntityRepository $commentsEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->commentsEntityRepository = $commentsEntityRepository;
    }

    public function commentCreate(CommentCreateRequest $request)
    {
        $region = $this->entityManager->getRepository(RegionsEntity::class)->find($request->region);
        $request->setRegion($region);

        $user = $this->entityManager->getRepository(User::class)->find($request->user);
        $request->setUser($user);

        $commentCreate = $this->autoMapping->map(CommentCreateRequest::class, CommentsEntity::class, $request);

        $commentCreate->setDate($request->getDate());

        $this->entityManager->persist($commentCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $commentCreate;
    }

    public function getComments()
    {

    }
}