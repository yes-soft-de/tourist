<?php


namespace App\Request;


class TouristOrderUpdateRequest
{
    public $id;

    public $guidUserID;

    public $city;

    public $language;

    public $services = [];

    public $roomID;

    public $status;

    public $cost;
}