import { createFeatureSelector, createSelector } from "@ngrx/store";
import { authsFeatureKey, AuthState } from "./auth.reducer";

const authFeatureState = createFeatureSelector<AuthState>(authsFeatureKey);

export const getErrorAuth = createSelector(authFeatureState, state => state.error);