import { Component, OnDestroy, OnInit } from '@angular/core';
import {forkJoin, Observable, Subscription} from 'rxjs';
import { FooterComponent } from 'src/app/@theme/components';
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

  constructor(private dashboardService: DashboardService) {
  }

  ngOnInit() {
    this.allStatistics = true;
  }

  ngOnDestroy() {
    // this.combinedObservable.unsubscribe();
  }

}
