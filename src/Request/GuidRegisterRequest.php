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

    public $places = [];

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
     * Get the value of places
     */ 
    public function getPlaces(): array
    {
        return $this->places;
    }

    /**
     * Set the value of places
     *
     * @return  self
     */ 
    public function setPlaces(array $places)
    {
        $this->places = $places;

        return $this;
    }
}