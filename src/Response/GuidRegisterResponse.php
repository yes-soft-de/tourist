<?php


namespace App\Response;


class GuidRegisterResponse
{
    public $id;
    
    public $userID;

    public $email;

    public $name;

    public $roles = [];

    public $createDate;

    public $places = [];
}