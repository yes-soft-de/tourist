<?php

namespace App\Controller;

use App\AutoMapping;
use App\Request\EventCreateRequest;
use App\Service\EventService;
use stdClass;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Serializer\SerializerInterface;

class EventController extends BaseController
{
    private $serializer;
    private $autoMapping;
    private $eventService;

    public function __construct(SerializerInterface $serializer, AutoMapping $autoMapping, EventService $eventService)
    {
        parent::__construct($serializer);
        $this->serializer = $serializer;
        $this->autoMapping = $autoMapping;
        $this->eventService = $eventService;
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

        $response = $this->eventService->eventCreate($request);

        return $this->response($response, self::CREATE);
    }

    /**
     * @Route("/event", name="event", methods={"GET"})
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

}
