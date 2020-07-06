<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\ImagesEntity;
use App\Entity\RegionsEntity;
use App\Entity\User;
use App\Repository\ImagesEntityRepository;
use App\Request\ImageCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ImageManager
{
    private $autoMapping;
    private $entityManager;
    private $imagesEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, ImagesEntityRepository $imagesEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->imagesEntityRepository = $imagesEntityRepository;
    }

    public function imageCreate(ImageCreateRequest $request)
    {
        if ($request->region)
        {
            $region = $this->entityManager->getRepository(RegionsEntity::class)->find($request->region);
            $request->setRegion($region);
        }

        if ($request->guid)
        {
            $guid = $this->entityManager->getRepository(User::class)->find($request->guid);
            $request->setGuid($guid);
        }

        $imageCreate = $this->autoMapping->map(ImageCreateRequest::class, ImagesEntity::class, $request);

        $this->entityManager->persist($imageCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $imageCreate;
    }

    public function getRegionImages($id)
    {
        return $this->imagesEntityRepository->getRegionImages($id);
    }

    public function getGuidImage($guidID)
    {
        return $this->imagesEntityRepository->getGuidImage($guidID);
    }
}