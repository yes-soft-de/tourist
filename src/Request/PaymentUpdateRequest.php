<?php


namespace App\Request;


use DateTime;

class PaymentUpdateRequest
{
    private $id;

    private $touristUserID;

    private $guidUserID;

    private $payment;

    private $date;

    private $token;

    private $createdAt;

    private $updatedAt;

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @param mixed $id
     */
    public function setId($id): void
    {
        $this->id = $id;
    }

    /**
     * @return mixed
     */
    public function getTouristUserID()
    {
        return $this->touristUserID;
    }

    /**
     * @param mixed $touristUserID
     */
    public function setTouristUserID($touristUserID): void
    {
        $this->touristUserID = $touristUserID;
    }

    /**
     * @return mixed
     */
    public function getGuidUserID()
    {
        return $this->guidUserID;
    }

    /**
     * @param mixed $guidUserID
     */
    public function setGuidUserID($guidUserID): void
    {
        $this->guidUserID = $guidUserID;
    }

    /**
     * @return mixed
     */
    public function getPayment()
    {
        return $this->payment;
    }

    /**
     * @param mixed $payment
     */
    public function setPayment($payment): void
    {
        $this->payment = $payment;
    }

    /**
     * @return mixed
     */
    public function getDate()
    {
        return new DateTime((string)$this->date);
    }

    /**
     * @param mixed $date
     */
    public function setDate($date): void
    {
        $this->date = $date;
    }

    /**
     * @return mixed
     */
    public function getToken()
    {
        return $this->token;
    }

    /**
     * @param mixed $token
     */
    public function setToken($token): void
    {
        $this->token = $token;
    }

    /**
     * @return mixed
     */
    public function getCreatedAt()
    {
        return new DateTime((string)$this->createdAt);
    }

    /**
     * @param mixed $createdAt
     */
    public function setCreatedAt($createdAt): void
    {
        $this->createdAt = $createdAt;
    }

    /**
     * @return mixed
     */
    public function getUpdatedAt()
    {
        return new DateTime((string)$this->updatedAt);
    }

    /**
     * @param mixed $updatedAt
     */
    public function setUpdatedAt($updatedAt): void
    {
        $this->updatedAt = $updatedAt;
    }


}