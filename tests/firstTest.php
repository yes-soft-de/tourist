<?php


namespace App\Tests;


use App\AutoMapping;
use App\Entity\ImagesEntity;
use App\Manager\ImageManager;
use App\Request\ImageCreateRequest;
use App\Response\ImageCreateResponse;
use App\Service\ImageService;
use PHPUnit\Framework\TestCase;

class firstTest extends TestCase
{

    private $mockImageManager;
    private $autoMapping;

    protected function setUp()
    {
        $this->mockImageManager = $this->createMock(ImageManager::class);
        $this->autoMapping = new AutoMapping();
    }

    public function test()
    {
        $CreateImageRequest = new ImageCreateRequest();
        $CreateImageRequest->path = 'imagePath';

        $imageEntity = new ImagesEntity();
        $imageEntity->setPath('imagePath');

        $imageResponse = new ImageCreateResponse();
        $imageResponse->path = 'imagePath';

        $this->mockImageManager
            ->method('imageCreate')
            ->willReturn($imageEntity);

        $imageService = new ImageService($this->autoMapping, $this->mockImageManager);

        $this->assertIsObject($imageService->imageCreate( $CreateImageRequest ));
        $this->assertEquals($imageResponse, $imageService->imageCreate( $CreateImageRequest ));
    }
}