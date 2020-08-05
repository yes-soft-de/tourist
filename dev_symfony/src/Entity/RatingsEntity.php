<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\RatingsEntityRepository")
 */
class RatingsEntity
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
    private $rate;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\RegionsEntity")
     */
    private $region;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\User")
     * @ORM\JoinColumn(nullable=false)
     */
    private $user;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\User")
     */
    private $guid;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getRate(): ?int
    {
        return $this->rate;
    }

    public function setRate(int $rate): self
    {
        $this->rate = $rate;

        return $this;
    }

    public function getRegion(): ?regionsEntity
    {
        return $this->region;
    }

    public function setRegion(?regionsEntity $region): self
    {
        $this->region = $region;

        return $this;
    }

    public function getUser(): ?user
    {
        return $this->user;
    }

    public function setUser(?user $user): self
    {
        $this->user = $user;

        return $this;
    }

    public function getGuid(): ?User
    {
        return $this->guid;
    }

    public function setGuid(?User $guid): self
    {
        $this->guid = $guid;

        return $this;
    }
}
