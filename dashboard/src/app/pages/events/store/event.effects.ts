import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { ToastrService } from 'ngx-toastr';
import { of } from 'rxjs';
import { catchError, exhaustMap, map, mergeMap, tap } from 'rxjs/operators';
import { EventsService } from '../services/events.service';
import * as eventActions from './event.actions';


@Injectable()
export class EventEffects {



  constructor(private actions$: Actions,            
              private eventService: EventsService,
              private toaster: ToastrService,
              private router: Router,
              private activatedRoute: ActivatedRoute) {}

  LoadEvents$ = createEffect(() => this.actions$.pipe(
    ofType(eventActions.loadEvents),
    mergeMap(() => this.eventService.getEvents()
      .pipe(
        map(response => {
          return eventActions.loadEventsSuccess({events: response.Data})
        }),
        catchError(error => {
          console.log('error events effect', error);
          return of(eventActions.loadEventsFailure(error))
        })
      ))
  ));

  loadEvent$ = createEffect(() => this.actions$.pipe(
    ofType(eventActions.loadEvent),
    mergeMap(action => this.eventService.getEventDetails(action.id)
      .pipe(
        map(response => {
          return eventActions.loadEventSuccess(response);
        }),
        catchError(error => {
          console.log('error :', error);
          return of(eventActions.loadEventFailure(error));
        })
      ))
  ));

  updateEvent$ = createEffect(() => this.actions$.pipe(
    ofType(eventActions.updateEvent),
    exhaustMap(action => this.eventService.updateEvent(action.event)
      .pipe(
        map((respones: any) => {
          console.log('response update effect: ', respones);
          this.toaster.success(respones.msg);
          return eventActions.updateEventSuccess()
        }),
        catchError(error => {
          console.log('error update effect :', error);
          return of(eventActions.updateEventFailure(error));
        }),
        tap(() => this.router.navigate(['events']))
      ))
  ), { dispatch: false });

  
}
