<?php

namespace App\Service;

use App\Request\AdminCreateRequest;

interface AdminServiceInterface
{
    public function adminCreate(AdminCreateRequest $request);
    public function deleteAdmin($userID);
    public function getAllAdministrators();
}