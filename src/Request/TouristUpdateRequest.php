<?php


namespace App\Request;


class TouristUpdateRequest
{
    public $userID;

    public $name;

    public $sex;

    public $nationality;

    public $guideLanguage;

    public $arrivalCity;

    public $arrivalDate;

    public $stayDays;

    public $interests = [];

    public $email;

    public $phoneNumber;

    public $image;

    // public $createDate;

}