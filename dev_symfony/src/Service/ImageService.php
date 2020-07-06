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

    public function regionImageCreate(ImageCreateRequest $request)
    {
        $regionImageCreate = $this->imageManager->imageCreate($request);

        $response = $this->autoMapping->map(ImagesEntity::class,ImageCreateResponse::class, $regionImageCreate);

        return $response;
    }
}