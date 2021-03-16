<?php


namespace App\Manager;

use App\AutoMapping;
use App\Entity\User;
use App\Repository\UserRepository;
use App\Request\AdminCreateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class AdminManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, UserPasswordEncoderInterface $encoder, 
    UserRepository $userRepository
    ) {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
    }

    public function adminCreate($request)
    {
        $adminCreate = $this->autoMapping->map(AdminCreateRequest::class, User::class, $request);

        $user = new User($request->getUserID());

        if ($request->getPassword()) 
        {
            $adminCreate->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        $adminCreate->setCreateDate(new \DateTime('now'));

        if ($request->getRoles() == null) 
        {
            $request->setRoles(['ROLE_ADMIN']);
        }

        $adminCreate->setRoles($request->getRoles());

        $this->entityManager->persist($adminCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $adminCreate;
    }

    public function deleteAdmin($userID)
    {
        $adminData = $this->userRepository->getUser($userID);

        if($adminData)
        {
            $this->entityManager->remove($adminData);
            $this->entityManager->flush();
        }

        return $adminData;
    }

    public function getAllAdministrators()
    {
        return $this->userRepository->getAllAdministrators();
    }
}
