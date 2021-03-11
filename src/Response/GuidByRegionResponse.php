<?php


namespace App\Response;


class GuidByRegionResponse
{
    public $user;

    public $name;

    public $status;

    //public $about;

    public $city = [];

    public $language = [];

    //public $phoneNumber;

    //public $cost;

    //public $service = [];

    public $rating;

    public $image = [];

    public $baseURL;
    
    public $imageURL;

    /**
     * @param array $image
     */
    public function setImage(array $image): void
    {
        $this->image = $image;
    }

    /**
     * @param mixed $rating
     */
    public function setRating($rating): void
    {
        $this->rating = $rating;
    }




}