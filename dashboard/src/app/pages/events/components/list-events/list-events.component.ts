import { Component, OnDestroy, OnInit } from '@angular/core';
import { Store } from '@ngrx/store';
import { Subscription } from 'rxjs';
import { EventState } from '../../store/event.reducer';
import { Events } from '../../model/event.model';
import * as eventAction from '../../store/event.actions';
import { getAllEventsSelector } from '../../store/event.selector';

@Component({
  selector: 'app-list-events',
  templateUrl: './list-events.component.html',
  styleUrls: ['./list-events.component.scss']
})
export class ListEventsComponent implements OnInit, OnDestroy {
  events: Events[];
  eventsList: Events[] = [];
  name: any;
  config: any;
  isDeleted: boolean;
  eventsSubscription: Subscription;

  constructor(private store: Store<EventState>) { }

  ngOnInit(): void {
    this.store.dispatch(eventAction.loadEvents());
    this.getAllEvents();
  }

  getAllEvents() {
    this.eventsSubscription = this.store.select(getAllEventsSelector).subscribe(
      data => {
        console.log('components data : ', data);
        this.events = data;
        this.eventsList = data;
      }
    );
    this.config = {
      itemsPerPage: 5,
      currentPage: 1,
      totalItems: this.eventsList.length
    };
  }

  // Fetch The Page Number On Page Change
  pageChanged(event) {
    this.config.currentPage = event;
  }

  applyFilter() {
    // if the search input value is empty
    if (!this.name) {
      this.eventsList = [...this.events];
    } else {
      this.eventsList = [];
      this.eventsList = this.events.filter(res => {
        if (res.name) {
          const name = res.name.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (name) {
            return name;
          }
        }
        if (res.location) {
          const location = res.location.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (location) {
            return location;
          }
        }
        if (res.status) {
          const status = res.status.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (status) {
            return status;
          }
        }
        if (res.type) {
          const type = res.type.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
          if (type) {
            return type;
          }
        }
      });
    }
  }

  ngOnDestroy() {
    this.eventsSubscription.unsubscribe();
  }


}
