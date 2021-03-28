import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AddEventComponent } from './components/add-event/add-event.component';
import { EditEventComponent } from './components/edit-event/edit-event.component';
import { ListEventsComponent } from './components/list-events/list-events.component';


const routes: Routes = [
  { path: '', component: ListEventsComponent },
  { path: 'add', component: AddEventComponent },
  { path: 'edit/:id', component: EditEventComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EventsRoutingModule { }
