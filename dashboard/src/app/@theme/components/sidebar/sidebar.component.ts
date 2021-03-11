import { DatePipe, DOCUMENT } from '@angular/common';
import { Component, HostListener, Inject, Input, OnInit, Renderer2 } from '@angular/core';
import { Router } from '@angular/router';
import { TranslateService } from '@ngx-translate/core';
import { AuthService } from '../../admin-service/auth/auth.service';
import { TokenService } from '../../admin-service/token/token.service';
import { LayoutService } from '../../helper/layout.service';
import { SidebarMenuItems } from '../../model/sidebar-menu-items';

@Component({
  selector: 'app-sidebar',
  templateUrl: './sidebar.component.html',
  styleUrls: ['./sidebar.component.scss'],
  providers: [DatePipe]
})
export class SidebarComponent implements OnInit {

  @Input() menus: SidebarMenuItems[];
  loggedIn: boolean;
  orders: any[] = [];
  ordersListFilter: any[] = [];
  name: string;
  disabled = false;
  selectLang = '';
  TransLang = [];

  constructor(private tokenService: TokenService,
              private authService: AuthService,
              private layoutService: LayoutService,
              public translate: TranslateService,
              private router: Router,
              private datePipe: DatePipe,
              @Inject(DOCUMENT) private document: Document,
              private render: Renderer2) {
    translate.setDefaultLang('en');
    translate.addLangs(['en', 'ar']);
    this.selectLang = 'en';
    translate.use('en');
  }

  ngOnInit() {
    this.getTransLanguage();
    this.authService.authState.subscribe(
      loggedIn => this.loggedIn = loggedIn
    );
  }

  setTransLanguage(){
    console.log('set new language', this.selectLang);
    const htmlTag = this.document.querySelector('html') as HTMLElement;
    const search_result = this.document.querySelector('.search-result') as HTMLElement;
    // change louder icon direction
    this.isElementExists();
    if (this.selectLang == 'ar') {
      // set all project direction
      this.render.setStyle(htmlTag, 'direction', 'rtl');
      // set sidebar direction
      this.render.setStyle(this.document.querySelector('.main-sidebar'), 'right', '0');
      // set sidebar button direction
      this.document.querySelectorAll('.btn.btn-link').forEach(e => {
        this.render.setStyle(e, 'text-align', 'right');
      });
      // set sidebar button icon direction
      this.document.querySelectorAll('.fa-custom').forEach(e => {
        this.render.setStyle(e, 'right', 'unset');
        this.render.setStyle(e, 'left', '10px');
      });
      // set sidebar form direction to ltr
      this.render.setStyle(this.document.querySelector('.custom-search-form'), 'direction', 'ltr');
      this.render.setStyle(this.document.querySelector('.input-group-prepend'), 'display', 'flex');
      this.render.addClass(this.document.querySelector('.input-group-text'), 'input-group-text-custom');
      // change bootstrap link to bootstrap-rtl version link
      this.document.querySelectorAll('link').forEach((e, k, i) => {
        if (e.href.search('bootstrap.min.css') > 0) {
          e.href = 'assets/css/bootstrap-rtl.min.css';
          e.removeAttribute('integrity');
          e.removeAttribute('crossorigin');
        }
      });
    } else {
      this.render.setStyle(htmlTag, 'direction', 'ltr');
      this.render.setStyle(this.document.querySelector('.main-sidebar'), 'right', '0');
      this.document.querySelectorAll('.btn.btn-link').forEach(e => {
        this.render.setStyle(e, 'text-align', 'left');
      });
      this.document.querySelectorAll('.fa-custom').forEach(e => {
        this.render.setStyle(e, 'right', '10px');
        this.render.setStyle(e, 'left', 'unset');
      });
      // this.render.setStyle(this.document.querySelector('.custom-search-form'), 'direction', 'ltr');
      this.render.removeClass(this.document.querySelector('.input-group-text'), 'input-group-text-custom');
      this.document.querySelectorAll('link').forEach((e, k, i) => {
        if (e.href.search('bootstrap-rtl.min.css') > 0) {
          e.href = 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css';
          e.setAttribute('integrity', 'sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm');
          e.setAttribute('crossorigin', 'anonymous');
        }
      });
    }
    this.translate.use(this.selectLang);
  }

  getTransLanguage(){
    this.TransLang = [...this.translate.getLangs()];
  }

  logout() {
    this.tokenService.deleteToken();
    this.authService.changeAuthStatus(false);
    this.router.navigate(['/login']);
  }

  clicked(value = null) {
    if (value) {
      this.layoutService.changeLayout(value);
      this.router.navigate(['/']);
    }
  }

  select(id: number) {
    this.disabled = false;
    // empty search input
    this.render.setProperty(this.document.getElementById('inlineFormInputGroupUsername2'), 'value', '');
    this.router.navigate(['/orders/view/', id]);
  }

  // Exists from search result page (if exists) using escape button
  @HostListener('document:keydown.escape', ['$event']) onKeydownHandler(event: KeyboardEvent) {
    this.disabled = false;
    // empty search input
    this.render.setProperty(this.document.getElementById('inlineFormInputGroupUsername2'), 'value', '');
  }

  // check if search-result div exists
  checkSearchDivExists() {
    // if (this.selectLang == 'ar') {
    //   let elementExists = setInterval(() => {
    //     const search_result = this.document.querySelector('.search-result') as HTMLElement;
    //     if (search_result) {
    //       this.render.setStyle(this.document.querySelector('.search-result'), 'left', 'unset');
    //       this.render.setStyle(this.document.querySelector('.search-result'), 'right', '-65vw');
    //       clearInterval(elementExists);
    //     }
    //   }, 10);
    // } else {
    //   let elementExists = setInterval(() => {
    //     const search_result = this.document.querySelector('.search-result') as HTMLElement;
    //     if (search_result) {
    //       this.render.setStyle(this.document.querySelector('.search-result'), 'right', 'unset');
    //       this.render.setStyle(this.document.querySelector('.search-result'), 'left', '-65vw');
    //       clearInterval(elementExists);
    //     }
    //   }, 10);
    // }
  }

  // check Element Exists
  isElementExists() {
    if (this.selectLang == 'ar') {
      const elementExists = setInterval(() => {
        const loaderIcon = this.document.querySelector('.lds-ring') as HTMLElement;
        if (loaderIcon) {
          // set loader icon direction
          this.render.setStyle(this.document.querySelector('.lds-ring'), 'left', '33.3%');
          this.render.setStyle(this.document.querySelector('.lds-ring'), 'right', 'unset');
          clearInterval(elementExists);
        }
      }, 10);
    }
  }

  applyFilter() {
    // if (this.name == '') {
    //   this.disabled = false;
    // } else {
    //   this.disabled = true;
    //   // run method if search input not empty
    //   this.checkSearchDivExists();
    // }
    // // if the search input value is empty
    // if (!this.name) {
    //   this.ordersListFilter = [...this.orders];
    // } else {
    //   this.ordersListFilter = [];
    //   this.ordersListFilter = this.orders.filter(res => {
    //     if (res.orderDate) {
    //       const orderDate = (this.datePipe.transform(new Date(res.orderDate.timestamp * 1000), 'yyyy-MM-dd')).toString().match(this.name.toLocaleLowerCase());
    //       if (orderDate) {
    //         return orderDate;
    //       }
    //     }
    //     if (res.id) {
    //       const id = res.id.toString().match(this.name.toLocaleLowerCase());
    //       if (id) {
    //         return id;
    //       }
    //     }
    //      if (res.orderID) {
    //       const orderID = res.orderID.toString().match(this.name.toLocaleLowerCase());
    //       if (orderID) {
    //         // display the Name Column
    //         return orderID;
    //       }
    //     }
    //      if (res.date) {
    //       const date = (this.datePipe.transform(new Date(res.date.timestamp * 1000), 'yyyy-MM-dd')).toString().match(this.name.toLocaleLowerCase());
    //       if (date) {
    //         return date;
    //       }
    //     }
    //     if (res.recipientName)  {
    //       const recipientName = res.recipientName.toLocaleLowerCase().match(this.name.toLocaleLowerCase());
    //       if (recipientName) {
    //         return recipientName;
    //       }
    //     }

    //   });
    // }
  }

}
