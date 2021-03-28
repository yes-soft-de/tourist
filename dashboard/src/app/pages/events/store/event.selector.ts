import { createFeatureSelector, createSelector } from "@ngrx/store";
import { eventsFeatureKey, EventState, selectAll } from "./event.reducer";

const eventsFeatureState = createFeatureSelector<EventState>(eventsFeatureKey);

export const getAllEventsSelector = createSelector(eventsFeatureState, selectAll);

export const getEventDetailsSelector = createSelector(eventsFeatureState, state => state.eventDetails);