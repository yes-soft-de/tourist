import { createFeatureSelector, createSelector } from "@ngrx/store";
import { SHARED_STATE_KEY } from "./shared.reducer";
import { SharedState } from "./shared.state";

const sharedFeatureState = createFeatureSelector<SharedState>(SHARED_STATE_KEY);

export const getLoadSpinner = createSelector(sharedFeatureState, state => state.showLoading);