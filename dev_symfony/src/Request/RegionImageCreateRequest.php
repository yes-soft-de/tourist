<?php


namespace App\Request;


class RegionImageCreateRequest
{
    public $path;

    public $region;

    /**
     * @param mixed $region
     */
    public function setRegion($region): void
    {
        $this->region = $region;
    }


}