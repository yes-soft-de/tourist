<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\User;
use App\Repository\UserRepository;
use App\Request\TouristRegisterRequest;
use App\Request\TouristUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class TouristsManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager,
                                UserPasswordEncoderInterface $encoder, UserRepository $userRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
    }

    public function TouristRegister(TouristRegisterRequest $request)
    {

        $touristRegister = $this->autoMapping->map(TouristRegisterRequest::class, User::class, $request);

        $user = new User($request->userID);

        if ($request->password)
        {
            $touristRegister->setPassword($this->encoder->encodePassword($user, $request->password));
        }

        $touristRegister->setCreateDate(new \DateTime('now'));

        if ($request->roles == null)
        {
            $request->roles = 'tourist';
        }
        $touristRegister->setRoles([$request->roles]);

        $this->entityManager->persist($touristRegister);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $touristRegister;
    }

    public function touristUpdate(TouristUpdateRequest $request)
    {
        $tourist = $this->userRepository->getUser($request->userID);

        if ($tourist)
        {
            $tourist = $this->autoMapping->mapToObject(TouristUpdateRequest::class,
                User::class, $request, $tourist);

            $this->entityManager->flush();
            $this->entityManager->clear();
            return $tourist;
        }
    }

    public function getTouristByUserID($userID)
    {
        return $this->userRepository->getUser($userID);
    }
}