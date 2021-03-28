import { Component, OnInit } from '@angular/core';
import { RegisterService } from '../../service/register.service';
import { ActivatedRoute, Router } from '@angular/router';
import { TokenService } from 'src/app/@theme/admin-service/token/token.service';
import { AuthService } from 'src/app/@theme/admin-service/auth/auth.service';
import { Store } from '@ngrx/store';
import { AppState } from 'src/app/@theme/store/app-state';
import { startLogin } from '../../store/auth.actions';
import { getErrorAuth } from '../../store/auth.selector';
import { Observable } from 'rxjs';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { setLoadSpinner } from 'src/app/@theme/store/shared/shared.actions';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
  loginForm: FormGroup;
  errors = [];
  error = null;
  process = false;

  constructor(private store: Store<AppState>) { }

  ngOnInit(): void {
    this.loginForm = new FormGroup({
      username: new FormControl(''),
      password: new FormControl('')
    });
    // Get Error Messages
    this.store.select(getErrorAuth).subscribe(
      error => {
        this.process = false;
        this.error = error; 
      }
    );
  }

  onSubmit() {
    this.process = true;
    // Form Code
    this.store.dispatch(setLoadSpinner({status: true}));
    this.store.dispatch(startLogin({data: this.loginForm.getRawValue()}));    
  }


}
