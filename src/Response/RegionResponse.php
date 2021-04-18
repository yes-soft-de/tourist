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

    public $userRating;

    public $regionImage = [];

    public $guides = [];

    public $placeId;

    /**
     * @param array $comments
     */
    public function setComments(array $comments): void
    {
        $this->comments = $comments;
    }

    /**
     * @param array $regionImage
     */
    public function setRegionImage(array $regionImage): void
    {
        $this->regionImage = $regionImage;
    }

    /**
     * @param mixed $ratingAverage
     */
    public function setRatingAverage($ratingAverage): void
    {
        $this->ratingAverage = $ratingAverage;
    }

    /**
     * @param array $guides
     */
    public function setGuides(array $guides): void
    {
        $this->guides = $guides;
    }

    public function setUserRating($userRating)
    {
        $this->userRating = $userRating;
    }


}