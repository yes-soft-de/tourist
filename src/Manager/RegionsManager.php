<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\RegionsEntity;
use App\Repository\RegionsEntityRepository;
use App\Request\RegionCreateRequest;
use Doctrine\ORM\EntityManagerInterface;

class RegionsManager
{
    private $autoMapping;
    private $entityManager;
    private $regionsEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RegionsEntityRepository $regionsEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->regionsEntityRepository = $regionsEntityRepository;
    }

    public function regionCreate(RegionCreateRequest $request)
    {
        $regionCreate = $this->autoMapping->map(RegionCreateRequest::class, RegionsEntity::class, $request);

        $this->entityManager->persist($regionCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $regionCreate;
    }

    public function getRegions()
    {
        return $this->regionsEntityRepository->getRegions();
    }

    public function getRegion($id)
    {
        return $this->regionsEntityRepository->getRegion($id);
    }

    public function getRegionByPlaceID($placeId)
    {
        return $this->regionsEntityRepository->getRegionByPlaceID($placeId);
    }
}