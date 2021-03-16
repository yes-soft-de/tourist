<?php


namespace App\Service;

use App\AutoMapping;
use App\Entity\User;
use App\Manager\AdminManager;
use App\Request\AdminCreateRequest;
use App\Response\AdminResponse;
use App\Response\AllAdminResponse;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class AdminService implements AdminServiceInterface
{
    private $autoMapping;
    private $adminManager;
    private $params;

    public function __construct(AutoMapping $autoMapping, AdminManager $adminManager, ParameterBagInterface $params)
    {
        $this->autoMapping = $autoMapping;
        $this->adminManager = $adminManager;

        $this->params = $params->get('upload_base_url') . '/';
    }

    public function adminCreate(AdminCreateRequest $request)
    {
        $adminCreate = $this->adminManager->adminCreate($request);

        return $this->autoMapping->map(User::class, AdminResponse::class, $adminCreate);
    }

    public function deleteAdmin($userID)
    {
        $adminResult = $this->adminManager->deleteAdmin($userID);

        return $this->autoMapping->map(User::class, AdminResponse::class, $adminResult);
    }

    public function getAllAdministrators()
    {
        $response = [];
        $result = $this->adminManager->getAllAdministrators();
        
        foreach ($result as $row)
        {
            $row['imageURL'] = $row['image'];
            $row['baseURL'] = $this->params;

            $row['image'] = $this->params.$row['image'];

            $response[] = $this->autoMapping->map('array', AllAdminResponse::class, $row);
        }

        return $response;
    }
}
