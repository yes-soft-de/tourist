import { Component, OnInit } from '@angular/core';
import { RegisterService } from '../../service/register.service';
import { ActivatedRoute, Router } from '@angular/router';
import { TokenService } from 'src/app/@theme/admin-service/token/token.service';
import { AuthService } from 'src/app/@theme/admin-service/auth/auth.service';
import { Store } from '@ngrx/store';
import { AppState } from 'src/app/@theme/store/app-state';
import { startLogin } from '../../store/auth.actions';
import { getErrorAuth } from '../../store/auth.selector';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  errors = [];
  error = null;
  public form = {
    username: null,
    password: null
  };
  process = false;

  constructor(private store: Store<AppState>) { }

  ngOnInit(): void {
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
    this.store.dispatch(startLogin({data: this.form}));    
  }


}
