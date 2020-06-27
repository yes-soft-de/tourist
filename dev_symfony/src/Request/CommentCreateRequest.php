<?php


namespace App\Request;


use DateTime;

class CommentCreateRequest
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

    public function getDate():?\DateTime
    {
        try
        {
            return new DateTime((string)$this->date);
        }
        catch (\Exception $e)
        {
        }
    }

    public function setDate(\DateTime $date): self
    {
        try
        {
            $this->date = new \DateTime((string)$date);
        }
        catch (\Exception $e)
        {
        }

        return $this;
    }
}