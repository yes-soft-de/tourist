<?php


namespace App\Response;


class CommentCreateResponse
{
    public $comment;

    public $date;

    public $region;

    public $user;

    /**
     * @param mixed $region
     */
    public function setRegion($region): void
    {
        $this->region = $region;
    }

    /**
     * @param mixed $user
     */
    public function setUser($user): void
    {
        $this->user = $user;
    }


}