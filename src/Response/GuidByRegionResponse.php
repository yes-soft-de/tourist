<?php


namespace App\Response;


class GuidByRegionResponse
{
    public $id;

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

    public $myOrders;

    public $cities; // cities of guide which are used in dashboard

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