<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\ImageCreateRequest;
use App\Service\ImageService;
use Aws\Credentials\CredentialProvider;
use Aws\Exception\AwsException;
use Aws\S3\S3Client;
use League\Flysystem\AdapterInterface;
use League\Flysystem\FilesystemInterface;
use stdClass;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;
use Symfony\Component\HttpFoundation\File\File;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class ImagesController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $imageService;
    private $validator;
    /**
     * @var FilesystemInterface
     */
    private $filesystem;

    public function __construct( FilesystemInterface $publicFileSystem, SerializerInterface $serializer, AutoMapping $autoMapping, ImageService $imageService, ValidatorInterface $validator)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->imageService = $imageService;
        $this->validator = $validator;
        $this->filesystem = $publicFileSystem;
    }

    /**
     * @Route("/image", name="saveRegionImages", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function saveImages(Request $request)
    {

        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,ImageCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->imageService->imageCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/s", name="s3", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function test(Request $request)
    {
        $imageFile = $request->files->get('image');

        $this->upload($imageFile);

        return new JsonResponse(["done"]);
    }

    public function upload(UploadedFile $file)
    {
        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $originalFilename; //todo add more strong file renaming
        $fileName = $safeFilename.'-'.uniqid().'.'.$file->guessExtension();


        //$file = new UploadedFile($imageFile, "what");

        //dd($fileName);
        $stream = fopen($file->getPathname(), 'r');

        $this->filesystem->writeStream(
            $fileName, $stream,
        [
            'visibility' => AdapterInterface::VISIBILITY_PUBLIC
        ]);


        if (is_resource($stream))
        {
            fclose($stream);
        }


    }

    /**
     * @Route("/images/{regionID}", name="deleteRegionImages", methods="DELETE")
     */
    public function deleteRegion($regionID)
    {
        $response = $this->imageService->deleteImages($regionID);

        return $this->response($response, self::DELETE);
    }
}
