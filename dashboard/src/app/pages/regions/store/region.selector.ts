import { createFeatureSelector, createSelector } from "@ngrx/store";
import { regionsFeatureKey, RegionState, selectAll } from "./region.reducer";

const regionsFeatureState = createFeatureSelector<RegionState>(regionsFeatureKey);

export const getAllRegionsSelector = createSelector(regionsFeatureState, selectAll);