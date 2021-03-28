import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { EventsRoutingModule } from './events-routing.module';
import { ListEventsComponent } from './components/list-events/list-events.component';
import { AddEventComponent } from './components/add-event/add-event.component';
import { StoreModule } from '@ngrx/store';
import * as fromEvent from './store/event.reducer';
import { EffectsModule } from '@ngrx/effects';
import { EventEffects } from './store/event.effects';
import { ThemeModule } from 'src/app/@theme/theme.module';
import { EditEventComponent } from './components/edit-event/edit-event.component';


@NgModule({
  declarations: [ListEventsComponent, AddEventComponent, EditEventComponent],
  imports: [
    ThemeModule,
    EventsRoutingModule,
    StoreModule.forFeature(fromEvent.eventsFeatureKey, fromEvent.reducer),
    EffectsModule.forFeature([EventEffects])
  ]
})
export class EventsModule { }
