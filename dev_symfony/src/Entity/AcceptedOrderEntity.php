<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\AcceptedOrderEntityRepository")
 */
class AcceptedOrderEntity
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="integer")
     */
    private $orderID;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $guidUserID;

    /**
     * @ORM\Column(type="date")
     */
    private $date;

    /**
     * @ORM\Column(type="string", length=15, nullable=true)
     */
    private $cost;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $touristUserID;

    /**
     * @ORM\Column(type="string", length=15, nullable=true)
     */
    private $status;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getOrderID(): ?int
    {
        return $this->orderID;
    }

    public function setOrderID(int $orderID): self
    {
        $this->orderID = $orderID;

        return $this;
    }

    public function getGuidUserID(): ?string
    {
        return $this->guidUserID;
    }

    public function setGuidUserID(string $guidUserID): self
    {
        $this->guidUserID = $guidUserID;

        return $this;
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

    public function getCost(): ?string
    {
        return $this->cost;
    }

    public function setCost(?string $cost): self
    {
        $this->cost = $cost;

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
