<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\GuidEntity;
use App\Entity\User;
use App\Repository\GuidEntityRepository;
use App\Repository\UserRepository;
use App\Request\GuidProfileCreateRequest;
use App\Request\GuidProfileUpdateRequest;
use App\Request\GuidRegisterRequest;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class GuidManager
{
    private $autoMapping;
    private $entityManager;
    private $encoder;
    private $userRepository;
    private $guidEntityRepository;
    /**
     * @var RegionsManager
     */
    private $regionsManager;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, GuidEntityRepository $guidEntityRepository,
                                UserPasswordEncoderInterface $encoder, UserRepository $userRepository, RegionsManager $regionsManager)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->encoder = $encoder;
        $this->userRepository = $userRepository;
        $this->guidEntityRepository = $guidEntityRepository;
        $this->regionsManager = $regionsManager;
    }

    public function guidRegister(GuidRegisterRequest $request)
    {
        $guidRegister = $this->autoMapping->map(GuidRegisterRequest::class, User::class, $request);

        $user = new User($request->userID);

        if ($request->getPassword())
        {
            $guidRegister->setPassword($this->encoder->encodePassword($user, $request->getPassword()));
        }

        $guidRegister->setCreateDate(new \DateTime('now'));

        if ($request->roles == null)
        {
            $request->roles = 'guid';
        }
        $guidRegister->setRoles([$request->roles]);

        $this->entityManager->persist($guidRegister);
        $this->entityManager->flush();
        //$this->entityManager->clear();

        //create profile
        $this->guidProfileCreate($request);

        return $guidRegister;
    }

    private function guidProfileCreate(GuidRegisterRequest $request)
    {
        $user = $this->getGuidID($request->userID);

        $profile = new GuidProfileCreateRequest();

        $profile->user = $user;
        $profile->name = $request->name;

        //$request->setUserID($user);

        $guidProfile = $this->autoMapping->map(GuidProfileCreateRequest::class, GuidEntity::class, $profile);

        $this->entityManager->persist($guidProfile);
        $this->entityManager->flush();
        $this->entityManager->clear();
    }

    private function getGuidID($userID)
    {
        return $this->userRepository->getUser($userID);
    }

    public function updateGuidProfile(GuidProfileUpdateRequest $request)
    {
        $user = $this->userRepository->getUser($request->user);

        $guid = $this->guidEntityRepository->getGuid($user);
         //dd($guid);

        $request->setUser($user);

         if ($guid)
        {
            $profile = $this->autoMapping->mapToObject(GuidProfileUpdateRequest::class,
                GuidEntity::class, $request, $guid);

            $this->entityManager->flush();
            $this->entityManager->clear();
            return $profile;
        }
    }

    public function getGuidByRegion($regionID)
    {
        $city = $this->regionsManager->getRegion($regionID);

        return $this->guidEntityRepository->getGuidByRegion($city['name']);
    }

    public function getGuides()
    {
        return $this->guidEntityRepository->getGuides();
    }

}