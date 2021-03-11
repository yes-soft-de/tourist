<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\User;
use App\Manager\TouristsManager;
use App\Request\TouristRegisterRequest;
use App\Request\TouristRegisterResponse;
use App\Request\TouristUpdateRequest;
use App\Response\TouristUpdateResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class TouristsService
{
    private $touristsManager;
    private $autoMapping;
    private $params;

    public function __construct(AutoMapping $autoMapping, TouristsManager $touristsManager, ParameterBagInterface $params)
    {
        $this->touristsManager = $touristsManager;
        $this->autoMapping = $autoMapping;
        $this->params = $params->get('upload_base_url') . '/';
    }

    public function touristRegister(TouristRegisterRequest $request)
    {
        $touristRegister = $this->touristsManager->TouristRegister($request);

        $response = $this->autoMapping->map(User::class,TouristRegisterResponse::class, $touristRegister);

        return $response;
    }

    public function touristUpdate(TouristUpdateRequest $request)
    {
        $touristUpdate = $this->touristsManager->touristUpdate($request);

        $response = $this->autoMapping->map(User::class,TouristUpdateResponse::class, $touristUpdate);

        return $response;
    }

    public function getTouristByUserID($userId)
    {
        $item = $this->touristsManager->getTouristByUserID($userId);
        if($item){
            $item->imageURL = $item->getImage();
            $item->setImage($this->params.$item->getImage());
            $item->baseURL = $this->params;
         }
        
        return $this->autoMapping->map(User::class, TouristUpdateResponse::class, $item);
    }
}