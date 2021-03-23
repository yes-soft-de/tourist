<?php


namespace App\Request;


class GuidesFilterRequest
{
    public $language;

    public $city;
    
    public function getLanguage()
    {
        return $this->language;
    }

    public function getCity()
    {
        return $this->city;
    }
}