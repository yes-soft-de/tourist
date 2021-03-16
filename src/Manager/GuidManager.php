<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\GuidEntity;
use App\Entity\User;
use App\Repository\GuidEntityRepository;
use App\Repository\UserRepository;
use App\Request\GuidProfileCreateRequest;
use App\Request\GuidProfileUpdateRequest;
use App\Request\guidByAdminUpdateRequest;
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
        $profile->places = $request->places;

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

        $request->setUser($user);

        if ($guid)
        {
            $guid = $this->autoMapping->mapToObject(GuidProfileUpdateRequest::class, GuidEntity::class, $request, $guid);

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $guid;
        }
    }

    public function guidByAdminUpdate(guidByAdminUpdateRequest $request)
    {
        $guid = $this->guidEntityRepository->getGuidByGuidId($request->getId());

         if ($guid)
        {
            $profile = $this->autoMapping->mapToObject(guidByAdminUpdateRequest::class,
                GuidEntity::class, $request, $guid);

            $this->entityManager->flush();
            $this->entityManager->clear();
            return $profile;
        }
    }

    public function getGuidByRegion($regionID)
    {
        $city =[];
        $city = $this->regionsManager->getRegion($regionID);
        if ($city) {
             return $this->guidEntityRepository->getGuidByRegion($city['name']);
        }
        return $city;
    }

    public function guidByPlaceId($placeId)
    {
        return $this->guidEntityRepository->guidByPlaceId($placeId);
    }

    public function getGuides()
    {
        return $this->guidEntityRepository->getGuides();
    }

    public function getguideByUserID($userID)
    {
        return $this->guidEntityRepository->getUser($userID);
    }

    public function guideById($id)
    {
        return $this->guidEntityRepository->guideById($id);
    }
}