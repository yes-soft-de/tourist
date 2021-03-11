<?php


namespace App\Response;


class RegionsResponse
{

    public $id;

    public $name;

    public $description;

    public $location;

    public $commentNumber;

    public $ratingAverage;

    public $path = [];

    public $placeId;

    /**
     * @param mixed $commentNumber
     */
    public function setCommentNumber($commentNumber): void
    {
        $this->commentNumber = $commentNumber;
    }


}