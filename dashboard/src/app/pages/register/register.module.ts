import { NgModule } from '@angular/core';
import { ThemeModule } from 'src/app/@theme/theme.module';
import { RegisterRoutingModule } from './register-routing.module';

import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './register.component';

import { RegisterService } from './service/register.service';
import { StoreModule } from '@ngrx/store';
import * as fromAuth from './store/auth.reducer';
import { EffectsModule } from '@ngrx/effects';
import { AuthEffects } from './store/auth.effects';


@NgModule({
  declarations: [
    LoginComponent,
    RegisterComponent,
  ],
  imports: [
    ThemeModule,
    RegisterRoutingModule,
    EffectsModule.forFeature([AuthEffects])
  ],
  providers: [RegisterService]
})
export class RegisterModule { }
