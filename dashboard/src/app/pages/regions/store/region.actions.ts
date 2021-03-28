import { createAction, props } from '@ngrx/store';
import { Update } from '@ngrx/entity';

import { Region } from '../model/region.model';

export const loadRegions = createAction('[Region/API] Load Regions');

export const loadRegionsSuccess = createAction(
  '[Region/API] Load Regions Success', 
  props<{ Data: Region[] }>()
);

export const loadRegionsFailure = createAction(
  '[Region/API] Load Regions Failure', 
  props<{ error: string }>()
);

export const loadRegion = createAction(
  '[Region/API] Load Region',
  props<{ id: number }>()
);

export const loadRegionSuccess = createAction(
  '[Region/API] Load Region Success', 
  props<{ region: Region }>()
);

export const loadRegionFailure = createAction(
  '[Region/API] Load Region Failure', 
  props<{ error: string }>()
);

export const deleteRegion = createAction(
  '[Region/API] Delete Region',
  props<{ id: number }>()
);

export const deleteRegionSuccess = createAction(
  '[Region/API] Delete Region Success'
);


export const deleteRegionFailure = createAction(
  '[Region/API] Delete Region Failure',
  props<{ error: string }>()
);

export const addRegion = createAction(
  '[Region/API] Add Region',
  props<{ region: Region }>()
);

export const addRegionSuccess = createAction(
  '[Region/API] Add Region Success'
);

export const addRegionFailure = createAction(
  '[Region/API] Add Region Failure',
  props<{ error: string }>()
);

export const upsertRegion = createAction(
  '[Region/API] Upsert Region',
  props<{ region: Region }>()
);

export const addRegions = createAction(
  '[Region/API] Add Regions',
  props<{ regions: Region[] }>()
);

export const upsertRegions = createAction(
  '[Region/API] Upsert Regions',
  props<{ regions: Region[] }>()
);

export const updateRegion = createAction(
  '[Region/API] Update Region',
  props<{ region: Update<Region> }>()
);

export const updateRegions = createAction(
  '[Region/API] Update Regions',
  props<{ regions: Update<Region>[] }>()
);

export const deleteRegions = createAction(
  '[Region/API] Delete Regions',
  props<{ ids: string[] }>()
);

export const clearRegions = createAction(
  '[Region/API] Clear Regions'
);
