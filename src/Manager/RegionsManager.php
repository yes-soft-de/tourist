<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\RegionsEntity;
use App\Repository\RegionsEntityRepository;
use App\Repository\ImagesEntityRepository;
use App\Request\RegionCreateRequest;
use App\Request\RegionUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use App\Request\ImageCreateRequest;
use App\Manager\ImageManager;

class RegionsManager
{
    private $autoMapping;
    private $entityManager;
    private $regionsEntityRepository;
    private $imagesEntityRepository;
    private $imageManager;
    private $commentManager;
    private $ratingManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, RegionsEntityRepository $regionsEntityRepository,  
    ImagesEntityRepository $imagesEntityRepository, ImageManager $imageManager, CommentsManager $commentManager, RatingManager $ratingManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->regionsEntityRepository = $regionsEntityRepository;
        $this->imagesEntityRepository = $imagesEntityRepository;
        $this->imageManager = $imageManager;
        $this->commentManager = $commentManager;
        $this->ratingManager = $ratingManager;
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

    public function update(RegionUpdateRequest $request)
    {
       
        $region = $this->regionsEntityRepository->Region($request->getId());

        $image = $this->imagesEntityRepository->getRegionImage($region);
         
        if($image) {
            $image->setPath($request->getPath());
            $region = $this->autoMapping->mapToObject(RegionUpdateRequest::class,
            RegionsEntity::class, $request, $region);
            $this->entityManager->flush();
            $this->entityManager->clear();
            return $region;
            }
       
        if(!$image){

            $region = $this->autoMapping->mapToObject(RegionUpdateRequest::class,
            RegionsEntity::class, $request, $region);
            $this->entityManager->flush();
            $this->entityManager->clear();

             //save image
            $regionImage =  new ImageCreateRequest();
            $regionImage->path = $request->path;
            $regionImage->region = $region->getId();
    
            $path = $this->imageManager->imageCreate($regionImage);
        
            $imagePathResponse = $this->autoMapping->map(ImagesEntity::class,ImageCreateResponse::class, $path);
            $region->setPath($imagePathResponse->getPath());
            return $region;
        }
  
    }
    
    public function getGuidByRegion($id)
    {
        // return $this->guideManager->getGuidByRegion($id);
    }

    public function getRegionsByName($name)
    {
        return $this->regionsEntityRepository->getRegionsByName($name);
    }

    public function delete($id)
    {
        $region = $this->regionsEntityRepository->find($id);

        if($region)
        {
            //first, we have to delete the related image

            $image = $this->imageManager->getRegionImage($region->getId());

            if($image)
            {
                $this->entityManager->remove($image);
                $this->entityManager->flush();
            }

            //also, we have to delete the related comments

            $comments = $this->commentManager->getCommentsByRegion($region->getId());

            if(isset($comments))
            {
                foreach($comments as $comment)
                {
                    $this->entityManager->remove($comment);
                    $this->entityManager->flush();
                }
            }

            //third, we have to delete the related ratings

            $this->ratingManager->getRatingsByRegion($region->getId());

            //now, we delete the region

            $this->entityManager->remove($region);
            $this->entityManager->flush();
        }

        return $region;
    }
}
