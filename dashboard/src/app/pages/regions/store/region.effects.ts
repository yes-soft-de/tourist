import { Injectable } from '@angular/core';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { of } from 'rxjs';
import { catchError, map, mergeMap } from 'rxjs/operators';
import { RegionsService } from '../services/regions.service';
import * as regionsAction from '../store/region.actions';



@Injectable()
export class RegionEffects {

  constructor(private actions$: Actions,
              private regionService: RegionsService) {}

  loadRegions$ = createEffect(() => this.actions$.pipe(
    ofType(regionsAction.loadRegions),
    mergeMap(() => this.regionService.getAllRegions()
      .pipe(
        map(response => regionsAction.loadRegionsSuccess(response)),
        catchError(error => {
          console.log('error effect: ', error);
          return of(regionsAction.loadRegionsFailure(error));
        })
      ))
  ));

  loadRegion$ = createEffect(() => this.actions$.pipe(
    ofType(regionsAction.loadRegion),
    mergeMap(action => this.regionService.createRegion(action.id)
      .pipe(
        map(response => regionsAction.loadRegionSuccess(response)),
        catchError(error => {
          console.log('error effect', error);
          return of(regionsAction.loadRegionFailure({error}))
        })
      ))
  ));
}
