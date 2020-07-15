<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\TouristOrderEntityRepository")
 */
class TouristOrderEntity
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="date")
     */
    private $date;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $touristUserID;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $guidUserID;

    /**
     * @ORM\Column(type="string", length=45)
     */
    private $city;

    /**
     * @ORM\Column(type="string", length=15)
     */
    private $language;

    /**
     * @ORM\Column(type="date")
     */
    private $arriveDate;

    /**
     * @ORM\Column(type="date")
     */
    private $leaveDate;

    /**
     * @ORM\Column(type="json", nullable=true)
     */
    private $services = [];

    /**
     * @ORM\Column(type="string", length=10)
     */
    private $cost;

    /**
     * @ORM\Column(type="string", length=255, nullable=true)
     */
    private $roomID;

    /**
     * @ORM\Column(type="string", length=10, nullable=true)
     */
    private $status;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(\DateTimeInterface $date): self
    {
        $this->date = $date;

        return $this;
    }

    public function getTouristUserID(): ?string
    {
        return $this->touristUserID;
    }

    public function setTouristUserID(string $touristUserID): self
    {
        $this->touristUserID = $touristUserID;

        return $this;
    }

    public function getGuidUserID(): ?string
    {
        return $this->guidUserID;
    }

    public function setGuidUserID(?string $guidUserID): self
    {
        $this->guidUserID = $guidUserID;

        return $this;
    }

    public function getCity(): ?string
    {
        return $this->city;
    }

    public function setCity(string $city): self
    {
        $this->city = $city;

        return $this;
    }

    public function getLanguage(): ?string
    {
        return $this->language;
    }

    public function setLanguage(string $language): self
    {
        $this->language = $language;

        return $this;
    }

    public function getArriveDate(): ?\DateTimeInterface
    {
        return $this->arriveDate;
    }

    public function setArriveDate(\DateTimeInterface $arriveDate): self
    {
        $this->arriveDate = $arriveDate;

        return $this;
    }

    public function getLeaveDate(): ?\DateTimeInterface
    {
        return $this->leaveDate;
    }

    public function setLeaveDate(\DateTimeInterface $leaveDate): self
    {
        $this->leaveDate = $leaveDate;

        return $this;
    }

    public function getServices(): ?array
    {
        return $this->services;
    }

    public function setServices(?array $services): self
    {
        $this->services = $services;

        return $this;
    }

    public function getCost(): ?string
    {
        return $this->cost;
    }

    public function setCost(string $cost): self
    {
        $this->cost = $cost;

        return $this;
    }

    public function getRoomID(): ?string
    {
        return $this->roomID;
    }

    public function setRoomID(?string $roomID): self
    {
        $this->roomID = $roomID;

        return $this;
    }

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(?string $status): self
    {
        $this->status = $status;

        return $this;
    }
}
