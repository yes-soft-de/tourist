<?php


namespace App\Request;


use DateTime;

class AcceptedOrderCreateRequest
{
    public $date;

    public $touristUserID;

    public $orderID;

    public $guidUserID;

    public $cost;

    public $status;

    private $uuid;

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

    /**
     * @return mixed
     */
    public function getDate():?\DateTimeInterface
    {
        try {
            return new DateTime((string)$this->date);
        } catch (\Exception $e) {
        }
    }
    
    public function getUuid(): ?string
    {
        return $this->uuid;
    }

    public function setUuid(?string $uuid): self
    {
        $this->uuid = $uuid;

        return $this;
    }

    public function getOrderID()
    {
        return $this->orderID;
    }

}