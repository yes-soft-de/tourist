import { Injectable } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Actions, createEffect, ofType } from '@ngrx/effects';
import { Store } from '@ngrx/store';
import { of } from 'rxjs';
import { catchError, exhaustMap, map, tap } from 'rxjs/operators';
import { AuthService } from 'src/app/@theme/admin-service/auth/auth.service';
import { TokenService } from 'src/app/@theme/admin-service/token/token.service';
import { AppState } from 'src/app/@theme/store/app-state';
import { setLoadSpinner } from 'src/app/@theme/store/shared/shared.actions';
import { RegisterService } from '../service/register.service';
import * as authAction from './auth.actions';



@Injectable()
export class AuthEffects {

  constructor(private actions$: Actions,
              private store: Store<AppState>,
              private registerService: RegisterService,
              private authService: AuthService,
              private router: Router,
              private activatedRouter: ActivatedRoute,
              private tokenService: TokenService) {}

  startLogin$ = createEffect(() => this.actions$.pipe(
    ofType(authAction.startLogin),
    exhaustMap(action => this.registerService.login(action.data)
      .pipe(
        map(response => {
          this.tokenService.handle(action.data.username, response.token);        
          this.authService.changeAuthStatus(true);
          this.store.dispatch(setLoadSpinner({status: false}));
          return authAction.successLogin();
        }),
        catchError(error => {
          let errorMessage: string;
          if (error.error.error) {
            errorMessage = error.error.error;
          } else if (error.error.message) {
            errorMessage = error.error.message;
          } else if (error.error.errors) {
            errorMessage = error.error.errors;
          }
          
          this.store.dispatch(setLoadSpinner({status: false}));
          return of(authAction.failureLogin({error: errorMessage}));
        })
      ))
  ));

  // Redirect After Success Login
  loginRedirect$ = createEffect(() => this.actions$.pipe(
    ofType(authAction.successLogin),
    tap(res => this.router.navigate(['../'], {relativeTo: this.activatedRouter}))
  ), { dispatch: false });

}
