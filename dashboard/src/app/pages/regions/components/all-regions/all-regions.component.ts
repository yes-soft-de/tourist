import { Component, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import { ToastrService } from 'ngx-toastr';
import { Observable, Subscription } from 'rxjs';
import { Region } from '../../model/region.model';
import * as regionsAction from '../../store/region.actions';
import { RegionState } from '../../store/region.reducer';
import { getAllRegionsSelector } from '../../store/region.selector';

@Component({
  selector: 'app-all-regions',
  templateUrl: './all-regions.component.html',
  styleUrls: ['./all-regions.component.scss']
})
export class AllRegionsComponent implements OnInit {
  regions: Region[];
  regionsList: Region[] = [];
  name: any;
  config: any;
  isDeleted: boolean;
  regionsSubscription: Subscription;

  constructor(private store: Store<RegionState>,
              private toaster: ToastrService) { }

  ngOnInit(): void {
    this.store.dispatch(regionsAction.loadRegions());
    this.getAllRegions();
  }

  getAllRegions() {
    this.regionsSubscription = this.store.select(getAllRegionsSelector).subscribe(
      data => {
        console.log(data);
        this.regions = data;
        this.regionsList = data;
      }
    );
    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.regionsList.length
    };
  }

  
  // Handle Response Error
  handleError(error) {
    console.log(error);
    if (error.error.error) {
      this.toaster.error(error.error.error);
    } else if (error.error.msg) {
      this.toaster.error(error.error.msg);
    }
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }

  delete(regionId: number) {
    if (confirm('Are You Sure You Want To Delete This Region')) {
      this.isDeleted = true;
      this.store.dispatch(regionsAction.deleteRegion({id: regionId}));
      this.toaster.success('Region Successfully Deleted');
      setTimeout(() => { this.isDeleted = false; }, 1000);      
    } else {
      return false;
    }
  }

  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.regionsList = [...this.regions];
    } else {
      this.regionsList = [];
      this.regionsList = this.regions.filter(res => {
        if (res.name) {
          const name = res.name.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (name) {
            // display the Name Column
            return name;
          }
        }
      });
    }
  }

}
