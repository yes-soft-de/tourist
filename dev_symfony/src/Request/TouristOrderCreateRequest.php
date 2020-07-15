<?php


namespace App\Request;


class TouristOrderCreateRequest
{
    public $date;

    public $touristUserID;

    public $guidUserID;

    public $city;

    public $language;

    public $arriveDate;

    public $leaveDate;

    public $services = [];

    public $roomID;

    public $status;

    public $cost;

    /**
     * @param mixed $date
     */
    public function setDate($date): void
    {
        $this->date = $date;
    }

    /**
     * @param mixed $arriveDate
     */
    public function setArriveDate($arriveDate): void
    {
        $this->arriveDate = $arriveDate;
    }

    /**
     * @param mixed $leaveDate
     */
    public function setLeaveDate($leaveDate): void
    {
        $this->leaveDate = $leaveDate;
    }

    /**
     * @param mixed $status
     */
    public function setStatus($status): void
    {
        $this->status = $status;
    }


}