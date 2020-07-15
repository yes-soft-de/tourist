<?php


namespace App\Request;


class AcceptedOrderCreateRequest
{
    public $date;

    public $touristUserID;

    public $orderID;

    public $guidUserID;

    public $cost;

    public $status;

    /**
     * @param mixed $date
     */
    public function setDate($date): void
    {
        $this->date = $date;
    }

    /**
     * @param mixed $status
     */
    public function setStatus($status): void
    {
        $this->status = $status;
    }


}