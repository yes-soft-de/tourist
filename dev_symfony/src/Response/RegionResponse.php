<?php


namespace App\Response;


class RegionResponse
{
    public $id;

    public $name;

    public $description;

    public $location;

    public $comments = [];

    public $ratingAverage;

    public $paths = [];

    /**
     * @param array $comments
     */
    public function setComments(array $comments): void
    {
        $this->comments = $comments;
    }

    /**
     * @param array $paths
     */
    public function setPaths(array $paths): void
    {
        $this->paths = $paths;
    }

    /**
     * @param mixed $ratingAverage
     */
    public function setRatingAverage($ratingAverage): void
    {
        $this->ratingAverage = $ratingAverage;
    }


}