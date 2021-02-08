<?php


namespace App\Response;


class GuidesResponse
{
    public $user;

    public $userID;

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