import { Action, createReducer, on } from '@ngrx/store';
import { EntityState, EntityAdapter, createEntityAdapter } from '@ngrx/entity';
import { Auth } from './auth.model';
import * as AuthActions from './auth.actions';

export const authsFeatureKey = 'auths';

export interface AuthState extends EntityState<Auth> {
  // additional entities state properties
}

export const adapter: EntityAdapter<Auth> = createEntityAdapter<Auth>();

export const initialState: AuthState = adapter.getInitialState({
  // additional entity state properties
});


export const reducer = createReducer(
  initialState,
  
);


export const {
  selectIds,
  selectEntities,
  selectAll,
  selectTotal,
} = adapter.getSelectors();
