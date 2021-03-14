import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AllRegionsComponent } from './all-regions.component';

describe('AllRegionsComponent', () => {
  let component: AllRegionsComponent;
  let fixture: ComponentFixture<AllRegionsComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AllRegionsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AllRegionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
