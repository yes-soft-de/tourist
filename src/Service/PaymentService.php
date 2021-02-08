<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\PaymentEntity;
use App\Manager\PaymentManager;
use App\Request\PaymentCreateRequest;
use App\Request\PaymentUpdateRequest;
use App\Response\PaymentResponse;

class PaymentService
{
    private $autoMapping;
    private $paymentManager;

    public function __construct(AutoMapping $autoMapping, PaymentManager $paymentManager)
    {
        $this->autoMapping = $autoMapping;
        $this->paymentManager = $paymentManager;
    }

    public function paymentCreate(PaymentCreateRequest $request)
    {
        $paymentCreate = $this->paymentManager->paymentCreate($request);

        return $this->autoMapping->map(PaymentEntity::class,PaymentResponse::class, $paymentCreate);
    }

    public function paymentUpdate(PaymentUpdateRequest $request)
    {
        $paymentUpdate = $this->paymentManager->paymentUpdate($request);

        return $this->autoMapping->map(PaymentEntity::class,PaymentResponse::class, $paymentUpdate);
    }

    public function getPayments()
    {
        $paymentsResponse = [];
        $payments = $this->paymentManager->getPayments();

        foreach ($payments as $payment)
        {
            $paymentsResponse[] = $this->autoMapping->map('array', PaymentResponse::class, $payment);
        }

        return $paymentsResponse;
    }

    public function getPaymentByTouristID($id)
    {
        $paymentsResponse = [];
        $payments = $this->paymentManager->getPaymentByTouristID($id);

        foreach ($payments as $payment)
        {
            $paymentsResponse[] = $this->autoMapping->map('array', PaymentResponse::class, $payment);
        }

        return $paymentsResponse;
    }

    public function getPaymentByGuidID($id)
    {
        $paymentsResponse = [];
        $payments = $this->paymentManager->getPaymentByGuidID($id);

        foreach ($payments as $payment)
        {
            $paymentsResponse[] = $this->autoMapping->map('array', PaymentResponse::class, $payment);
        }

        return $paymentsResponse;
    }

    public function getPaymentByID($id)
    {
        $result = $this->paymentManager->getPaymentByID($id);

        return $this->autoMapping->map('array', PaymentResponse::class, $result[0]);
    }

}