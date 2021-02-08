<?php


namespace App\Response;


class OrderByGuidCityAndLanguageResponse
{
    public $id;

    public $date;

    public $touristUserID;

    public $city = [];

    public $language = [];

    public $services = [];

    public $arriveDate;

    public $leaveDate;

    public $cost;

    public $status;
}