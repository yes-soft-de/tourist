import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { TokenService } from 'src/app/@theme/admin-service/token/token.service';
import { AdminConfig } from '../../AdminConfig';
import { EventDetailsResponse } from '../model/event-details-response.model';
import { EventsResponse } from '../model/event-response.model';

@Injectable({
  providedIn: 'root'
})
export class EventsService {

  constructor(private httpClient: HttpClient,
              private tokenService: TokenService) { }

  getEvents(): Observable<EventsResponse> {
    return this.httpClient.get<EventsResponse>(
      AdminConfig.eventsAPI,
      this.tokenService.httpOptions()
    );
  }

  getEventDetails(eventId: number): Observable<EventDetailsResponse> {
    return this.httpClient.get<EventDetailsResponse>(
      `${AdminConfig.eventAPI}/${eventId}`,
      this.tokenService.httpOptions()
    );
  }

  updateEvent(data): Observable<any> {
    return this.httpClient.put<any>(
      AdminConfig.eventAPI,
      data,
      this.tokenService.httpOptions()
    );
  }

}
