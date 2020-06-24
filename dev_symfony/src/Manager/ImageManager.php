<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\ImagesEntity;
use App\Entity\RegionsEntity;
use App\Request\RegionImageCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class ImageManager
{
    private $autoMapping;
    private $entityManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
    }

    public function regionImageCreate(RegionImageCreateRequest $request)
    {
        if ($request->region)
        {
            $region = $this->entityManager->getRepository(RegionsEntity::class)->find($request->region);
            $request->setRegion($region);
        }

        $regionImageCreate = $this->autoMapping->map(RegionImageCreateRequest::class, ImagesEntity::class, $request);

        $this->entityManager->persist($regionImageCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $regionImageCreate;
    }
}