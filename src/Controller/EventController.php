<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\EventCreateRequest;
use App\Request\EventUpdateRequest;
use App\Service\EventService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;
use Symfony\Component\Validator\Validator\ValidatorInterface;

class EventController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $eventService;
    private $validator;

    public function __construct(ValidatorInterface $validator, SerializerInterface $serializer, AutoMapping $autoMapping, EventService $eventService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->eventService = $eventService;
        $this->validator = $validator;
    }

    /**
     * @Route("/event", name="eventCreate", methods={"POST"})
     * @param Request $request
     * @return JsonResponse
     */
    public function eventCreate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class,EventCreateRequest::class,(object)$data);

        $violations = $this->validator->validate($request);
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->eventService->eventCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/events", name="event", methods={"GET"})
     * @return JsonResponse
     */
    public function event()
    {
        $response = $this->eventService->getEvents();

        return $this->response($response,self::FETCH);
    }

    /**
     * @Route("/event/{id}", name="eventByID", methods="GET")
     * @param Request $request
     * @return JsonResponse
     */
    public function eventByID(Request $request)
    {
        $response = $this->eventService->getEventByID($request->get('id'));

        return $this->response($response,self::FETCH);
    }

    //for ADMIN
    /**
     * @Route("/event", name="eventUpdate", methods={"PUT"})
     * @param Request $request
     * @return JsonResponse
     */
    public function eventUpdate(Request $request)
    {
        $data = json_decode($request->getContent(), true);

        $request = $this->autoMapping->map(stdClass::class, EventUpdateRequest::class,(object)$data);
        $violations = $this->validator->validate($request);
      
        if (\count($violations) > 0) {
            $violationsString = (string) $violations;

            return new JsonResponse($violationsString, Response::HTTP_OK);
        }

        $response = $this->eventService->eventUpdate($request);

        return $this->response($response, self::UPDATE);
    }
}
