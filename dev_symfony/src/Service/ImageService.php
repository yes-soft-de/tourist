<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\ImagesEntity;
use App\Manager\ImageManager;
use App\Request\RegionImageCreateRequest;
use App\Response\RegionImageCreateResponse;

class ImageService
{
    private $autoMapping;
    private $imageManager;

    public function __construct(AutoMapping $autoMapping, ImageManager $imageManager)
    {
        $this->autoMapping = $autoMapping;
        $this->imageManager = $imageManager;
    }

    public function regionImageCreate(RegionImageCreateRequest $request)
    {
        $regionImageCreate = $this->imageManager->regionImageCreate($request);

        $response = $this->autoMapping->map(ImagesEntity::class,RegionImageCreateResponse::class, $regionImageCreate);

        return $response;
    }
}