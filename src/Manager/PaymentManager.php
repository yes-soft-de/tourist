<?php


namespace App\Manager;


use App\AutoMapping;
use App\Entity\PaymentEntity;
use App\Repository\PaymentEntityRepository;
use App\Request\PaymentCreateRequest;
use App\Request\PaymentUpdateRequest;
use Doctrine\ORM\EntityManagerInterface;

class PaymentManager
{
    private $autoMapping;
    private $entityManager;
    private $paymentEntityRepository;

    public function __construct(AutoMapping $autoMapping, EntityManagerInterface $entityManager, PaymentEntityRepository $paymentEntityRepository)
    {
        $this->autoMapping = $autoMapping;
        $this->entityManager = $entityManager;
        $this->paymentEntityRepository = $paymentEntityRepository;
    }

    public function paymentCreate(PaymentCreateRequest $request)
    {
        $paymentCreate = $this->autoMapping->map(PaymentCreateRequest::class, PaymentEntity::class, $request);
        $paymentCreate->setDate($request->getDate());
        $paymentCreate->setCreatedAt($request->getCreatedAt());

        $this->entityManager->persist($paymentCreate);
        $this->entityManager->flush();
        $this->entityManager->clear();

        return $paymentCreate;
    }

    public function paymentUpdate(PaymentUpdateRequest $request)
    {
        $payment = $this->paymentEntityRepository->find($request->getId());

        if ($payment)
        {
            $payment = $this->autoMapping->mapToObject(PaymentUpdateRequest::class,
                PaymentEntity::class, $request, $payment);

            $payment->setDate($request->getDate());
            $payment->setCreatedAt($request->getCreatedAt());
            $payment->setUpdatedAt($request->getUpdatedAt());

            $this->entityManager->flush();
            $this->entityManager->clear();

            return $payment;
        }
    }

    public function getPayments()
    {
        return $this->paymentEntityRepository->getPayments();
    }

    public function getPaymentByTouristID($id)
    {
        return $this->paymentEntityRepository->getPaymentByTouristID($id);
    }

    public function getPaymentByGuidID($id)
    {
        return $this->paymentEntityRepository->getPaymentByGuidID($id);
    }

    public function getPaymentByID($id)
    {
        return $this->paymentEntityRepository->getPaymentByID($id);
    }
}