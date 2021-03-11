import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


const routes: Routes = [
  {
    path: 'login',
    loadChildren: () => import('./pages/register/register.module').then(m => m.RegisterModule),
  },
  { 
    path: '', 
    loadChildren: () => import('./pages/pages.module').then(m => m.PagesModule),
  },

];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
