import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AddRegionComponent } from './components/add-region/add-region.component';
import { AllRegionsComponent } from './components/all-regions/all-regions.component';
import { EditRegionComponent } from './components/edit-region/edit-region.component';


const routes: Routes = [
  { path: '', component: AllRegionsComponent },
  { path: 'add', component: AddRegionComponent },
  { path: ':id', component: EditRegionComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class RegionsRoutingModule { }
