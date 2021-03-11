import { createAction, props } from '@ngrx/store';

export const startLogin = createAction(
  '[Auth/API] Start Login', 
  props<{ email: string, password: string }>()
);
