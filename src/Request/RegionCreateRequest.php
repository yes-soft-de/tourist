<?php


namespace App\Request;


class RegionCreateRequest
{

    public $name;

    public $description;

    public $location = [];

    public $path;

    public $placeId;
}