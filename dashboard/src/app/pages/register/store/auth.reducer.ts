import { Action, createReducer, on } from '@ngrx/store';
import { EntityState, EntityAdapter, createEntityAdapter } from '@ngrx/entity';
import { Auth } from './auth.model';
import * as AuthActions from './auth.actions';

export const authsFeatureKey = 'auths';

export interface AuthState extends EntityState<Auth> {
  // additional entities state properties
  token: string;
  error: string;
}

export const adapter: EntityAdapter<Auth> = createEntityAdapter<Auth>();

export const initialState: AuthState = adapter.getInitialState({
  // additional entity state properties
  token: undefined,
  error: undefined
});


export const authReducer = createReducer(
  initialState,
  on(AuthActions.startLogin,
    (state, action) => {
      return {
        ...state
      };
    }),
  on(AuthActions.failureLogin,
    (state, action) => {
      return {
        ...state,
        error: action.error
      };
    })
  
);


export const {
  selectIds,
  selectEntities,
  selectAll,
  selectTotal,
} = adapter.getSelectors();
