<?php


namespace App\Request;


class GuidProfileUpdateRequest
{
    public $user;

    public $name;

    // public $status;

    public $about;

    public $city = [];

    public $language = [];

    public $phoneNumber;

    // public $cost;

    public $service = [];

    public $path;
    
    public $placeId;

    /**
     * @param mixed $user
     */
    public function setUser($user): void
    {
        $this->user = $user;
    }


}