import { Component, OnDestroy, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import {forkJoin, Observable, Subscription} from 'rxjs';
import { FooterComponent } from 'src/app/@theme/components';
import { AppState } from 'src/app/@theme/store/app-state';
import { setLoadSpinner } from 'src/app/@theme/store/shared/shared.actions';
import {DashboardService} from './services/dashboard.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss'],
  providers: [ FooterComponent ]
})
export class DashboardComponent implements OnInit, OnDestroy {
  allCars: any[];
  allDevices: any[];
  allStatistics: any;
  
  latestCarsNumber = 5;
  latestDevicesNumber = 5;
  latestRealEstateNumber = 5;

  combinedObservable: Subscription;

  constructor(private store: Store<AppState>,
              private dashboardService: DashboardService) {
  }

  ngOnInit() {
    this.allStatistics = true;
    // this.store.dispatch(setLoadSpinner({status: false}));
  }

  ngOnDestroy() {
    // this.combinedObservable.unsubscribe();
  }

}
