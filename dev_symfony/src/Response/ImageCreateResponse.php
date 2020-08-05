<?php


namespace App\Response;


class ImageCreateResponse
{
    public $path;

    /**
     * @return mixed
     */
    public function getPath()
    {
        return $this->path;
    }


}