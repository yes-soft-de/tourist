<?php


namespace App\Request;


class GuidRegisterRequest
{
    public $userID;

    public $email;

    private $password;

    public $name;

    public $roles = [];

    public $createDate;

    public $placeId;

    /**
     * @param array $roles
     */
    public function setRoles(array $roles): void
    {
        $this->roles = $roles;
    }

    /**
     * @return array
     */
    public function getRoles(): array
    {
        return $this->roles;
    }


    /**
     * @param mixed $createDate
     */
    public function setCreateDate($createDate): void
    {
        $this->createDate = $createDate;
    }

    /**
     * @param mixed $password
     */
    public function setPassword($password): void
    {
        $this->password = $password;
    }

    /**
     * @return mixed
     */
    public function getPassword()
    {
        return $this->password;
    }

    /**
     * @param mixed $userID
     */
    public function setUserID($userID): void
    {
        $this->userID = $userID;
    }

    /**
     * Get the value of placeId
     */ 
    public function getPlaceId()
    {
        return $this->placeId;
    }

    /**
     * Set the value of placeId
     *
     * @return  self
     */ 
    public function setPlaceId($placeId)
    {
        $this->placeId = $placeId;

        return $this;
    }
}