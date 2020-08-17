<?php


namespace App\Response;


class TouristOrderCreateResponse
{
    public $id;

    public $date;

    public $touristUserID;

    public $guidUserID;

    public $city;

    public $language;

    public $arriveDate;

    public $leaveDate;

    public $services = [];

    public $roomID;

    public $status;

    public $cost;
}