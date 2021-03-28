import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AfterLoginService } from '../@theme/admin-service/guard/after-login.service';
import { NotFoundComponent } from '../@theme/components';
import { PagesComponent } from './pages.component';


const routes: Routes = [
  {
    path: '',
    component: PagesComponent,
    children: [
      {
        path: '',
        loadChildren: () => import('./dashboard/dashboard.module').then(m => m.DashboardModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'regions',
        loadChildren: () => import('./regions/regions.module').then(m => m.RegionsModule),
        canActivate: [AfterLoginService]
      },
      {
        path: 'events',
        loadChildren: () => import('./events/events.module').then(m => m.EventsModule),
        canActivate: [AfterLoginService]
      },
      { path: '**', component: NotFoundComponent }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class PagesRoutingModule { }
