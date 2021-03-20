<?php


namespace App\Response;


class EventsResponse
{
    public $id;

    public $name;

    public $type;

    public $subType;

    public $date;

    public $status;

    public $location;

    public $description;

    public $images = [];

    public $commentNumber;

    public $comments = [];

    /**
     * @param array $comments
     */
    public function setComments(array $comments): void
    {
        $this->comments = $comments;
    }

    public function setCommentsNumber($commentsNumber): void
    {
        $this->commentNumber = $commentsNumber;
    }
}