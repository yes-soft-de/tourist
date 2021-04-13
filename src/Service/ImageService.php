<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\ImagesEntity;
use App\Manager\ImageManager;
use App\Request\ImageCreateRequest;
use App\Response\ImageCreateResponse;

class ImageService
{
    private $autoMapping;
    private $imageManager;

    public function __construct(AutoMapping $autoMapping, ImageManager $imageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
    }

    public function imageCreate(ImageCreateRequest $request)
    {
        $imageCreate = $this->imageManager->imageCreate($request);

        $response = $this->autoMapping->map(ImagesEntity::class,ImageCreateResponse::class, $imageCreate);

        return $response;
    }

    public function deleteImages($regionID)
    {
        $response = [];
        $images = $this->imageManager->deleteRegionImages($regionID);

        if(isset($images))
        {
            foreach($images as $image)
            {
                $response[] = $this->autoMapping->map(ImagesEntity::class, ImageCreateResponse::class, $image);
            }
        }

        return $response;
    }
}