<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\ImagesEntityRepository")
 */
class ImagesEntity
{
    /**
     * @ORM\Id()
     * @ORM\GeneratedValue()
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $path;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\RegionsEntity")
     */
    private $region;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\EventEntity")
     */
    private $event;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getPath(): ?string
    {
        return $this->path;
    }

    public function setPath(string $path): self
    {
        $this->path = $path;

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

    public function getEvent(): ?EventEntity
    {
        return $this->event;
    }

    public function setEvent(?EventEntity $event): self
    {
        $this->event = $event;

        return $this;
    }
}
