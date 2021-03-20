<?php


namespace App\Response;


class GuideProfileGetResponse
{
    public $id;

    public $user;

    public $name;

    public $status;

    public $about;

    public $city = [];

    public $language = [];

    public $phoneNumber;

    public $cost;

    public $service = [];

    public $image = [];

    public $baseURL;
    
    public $imageURL;

}