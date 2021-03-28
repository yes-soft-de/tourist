import { createAction, props } from '@ngrx/store';
import { Update } from '@ngrx/entity';

import { Events } from '../model/event.model';

export const loadEvents = createAction(
  '[Event/API] Load Events'
);

export const loadEventsSuccess = createAction(
  '[Event/API] Load Events Success', 
  props<{ events: Events[] }>()
);

export const loadEventsFailure = createAction(
  '[Event/API] Load Events Failure', 
  props<{ error: string }>()
);

export const loadEvent = createAction(
  '[Event/API] Load Event',
  props<{ id: number }>()
);

export const loadEventSuccess = createAction(
  '[Event/API] Load Event Success', 
  props<{ Data: Events }>()
);

export const loadEventFailure = createAction(
  '[Event/API] Load Event Failure', 
  props<{ error: string }>()
);

export const addEvent = createAction(
  '[Event/API] Add Event',
  props<{ event: Events }>()
);

export const updateEvent = createAction(
  '[Event/API] Update Event',
  props<{ event: Update<Events> }>()
  );
  
export const updateEventSuccess = createAction(
    '[Event/API] Update Event Success',
);

export const updateEventFailure = createAction(
  '[Event/API] Update Event Failure',
  props<{ error: string }>()
);
  

export const upsertEvent = createAction(
  '[Event/API] Upsert Event',
  props<{ event: Events }>()
);

export const addEvents = createAction(
  '[Event/API] Add Events',
  props<{ events: Events[] }>()
);

export const upsertEvents = createAction(
  '[Event/API] Upsert Events',
  props<{ events: Events[] }>()
);

export const updateEvents = createAction(
  '[Event/API] Update Events',
  props<{ events: Update<Events>[] }>()
);

export const deleteEvent = createAction(
  '[Event/API] Delete Event',
  props<{ id: string }>()
);

export const deleteEvents = createAction(
  '[Event/API] Delete Events',
  props<{ ids: string[] }>()
);

export const clearEvents = createAction(
  '[Event/API] Clear Events'
);
