import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { RegionsRoutingModule } from './regions-routing.module';
import { AllRegionsComponent } from './components/all-regions/all-regions.component';
import { StoreModule } from '@ngrx/store';
import * as fromRegion from './store/region.reducer';
import { EffectsModule } from '@ngrx/effects';
import { RegionEffects } from './store/region.effects';
import { ThemeModule } from 'src/app/@theme/theme.module';
import { AddRegionComponent } from './components/add-region/add-region.component';
import { EditRegionComponent } from './components/edit-region/edit-region.component';


@NgModule({
  declarations: [
    AllRegionsComponent, 
    AddRegionComponent,
    EditRegionComponent
  ],
  imports: [
    ThemeModule,
    RegionsRoutingModule,
    StoreModule.forFeature(fromRegion.regionsFeatureKey, fromRegion.reducer),
    EffectsModule.forFeature([RegionEffects])
  ]
})
export class RegionsModule { }
