<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\PaymentCreateRequest;
use App\Request\PaymentUpdateRequest;
use App\Service\PaymentService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class PaymentController extends BaseController
{
    private $autoMapping;
    private $paymentService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, PaymentService $paymentService)
    {
        parent::__construct($serializer);
        $this->autoMapping = $autoMapping;
        $this->paymentService = $paymentService;
    }

    /**
     * @Route("/payment", name="paymentCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function paymentCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,PaymentCreateRequest::class,(object)$data);

//        $violations = $this->validator->validate($request);
//        if (\count($violations) > 0) {
//            $violationsString = (string) $violations;
//
//            return new JsonResponse($violationsString, Response::HTTP_OK);
//        }

        $response = $this->paymentService->paymentCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/payment", name="paymentUpdate", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function paymentUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,PaymentUpdateRequest::class,(object)$data);

        $response = $this->paymentService->paymentUpdate($request);

        return $this->response($response, self::UPDATE);
    }

    /**
     * @Route("/payment/{id}", name="getpaymentByID", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getPaymentByID(Request $request)
    {
        $response = $this->paymentService->getPaymentByID($request->get('id'));

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/payment", name="getpayment", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getPayment()
    {
        $response = $this->paymentService->getPayments();

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/paymenttourist/{id}", name="getpaymenttourist", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getPaymentTourist(Request $request)
    {
        $response = $this->paymentService->getPaymentByTouristID($request->get('id'));

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/paymentguide/{id}", name="getpaymentguid", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function getPaymentGuid(Request $request)
    {
        $response = $this->paymentService->getPaymentByGuidID($request->get('id'));

        return $this->response($response,self::FETCH);
    }

}
