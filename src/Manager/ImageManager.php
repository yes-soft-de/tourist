<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\EventEntity;
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

        if ($request->event)
        {
            $event = $this->entityManager->getRepository(EventEntity::class)->find($request->event);
            $request->setEvent($event);
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

    public function getRegionImage($id)
    {
        return $this->imagesEntityRepository->getRegionImage($id);
    }

    public function getEventImage($id)
    {
        return $this->imagesEntityRepository->getEventImages($id);
    }

    public function getImageOfEvent($id)
    {
        return $this->imagesEntityRepository->getEventImage($id);
    }

    public function deleteRegionImages($regionID)
    {
        $images = $this->imagesEntityRepository->findBy(["region" => $regionID]);

        //dd($images);

        if(isset($images))
        {
            foreach ($images as $image)
            {
                $this->entityManager->remove($image);
                $this->entityManager->flush();
            }
        }

        return $images;
    }
}