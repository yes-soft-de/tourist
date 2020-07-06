<?php


namespace App\Response;


class GuidProfileUpdateResponse
{
    //public $user;

    public $id;

    public $name;

    public $status;

    public $about;

    public $city = [];

    public $language = [];

    public $phoneNumber;

    public $cost;

    public $service = [];

    public $path;

    /**
     * @param mixed $path
     */
    public function setPath($path): void
    {
        $this->path = $path;
    }


}