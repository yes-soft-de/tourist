<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * @ORM\Entity(repositoryClass="App\Repository\CommentsEntityRepository")
 */
class CommentsEntity
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
    private $comment;

    /**
     * @ORM\Column(type="datetime")
     */
    private $date;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\RegionsEntity")
     */
    private $region;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\User")
     */
    private $user;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\User")
     */
    private $guid;

    /**
     * @ORM\ManyToOne(targetEntity="App\Entity\EventEntity")
     */
    private $event;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getComment(): ?string
    {
        return $this->comment;
    }

    public function setComment(string $comment): self
    {
        $this->comment = $comment;

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

    public function getRegion(): ?RegionsEntity
    {
        return $this->region;
    }

    public function setRegion(?RegionsEntity $region): self
    {
        $this->region = $region;

        return $this;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): self
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
