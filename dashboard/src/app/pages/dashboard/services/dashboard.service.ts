import { Injectable } from '@angular/core';
import {HttpClient, HttpErrorResponse} from '@angular/common/http';
import {Observable, throwError} from 'rxjs';
import {AdminConfig} from '../../AdminConfig';
import { TokenService } from 'src/app/@theme/admin-service/token/token.service';

@Injectable({
  providedIn: 'root'
})
export class DashboardService {

  constructor(private httpClient: HttpClient,
              private tokenService: TokenService) { }


  private static errorHandler(error: HttpErrorResponse) {
    return throwError(error || 'Server Error');
  }

}
