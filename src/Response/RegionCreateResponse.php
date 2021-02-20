<?php


namespace App\Response;


class RegionCreateResponse
{
    public $id;

    public $name;

    public $description;

    public $location = [];

    public $path;

    public $placeId;

    /**
     * @param mixed $path
     */
    public function setPath($path): void
    {
        $this->path = $path;
    }


}