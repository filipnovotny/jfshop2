import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';

import { ModalModule } from 'angular2-modal';
import { BootstrapModalModule } from 'angular2-modal/plugins/bootstrap';

import { APP_CONFIG, AppConfig }  from 'portfolio/app/shared/config.service';

import { PortfolioComponent }  from 'portfolio/app/portfolio.component';
import { PictureModalComponent } from 'portfolio/app/picturemodal/picturemodal.component';

import {AppComponent} from './app.component';

export const PORTFOLIO_DI_CONFIG: AppConfig = {
  url: '/janela/picturesconfig/',
  title: 'Portfolio configuration'
};

@NgModule({
  imports: [ 
  	BrowserModule, 
  	HttpModule, 
  	ModalModule.forRoot(),
    BootstrapModalModule
  	],
  declarations: [ AppComponent,PortfolioComponent, PictureModalComponent ],
  providers: [{ provide: APP_CONFIG, useValue: PORTFOLIO_DI_CONFIG }],
  bootstrap: [ AppComponent ],

  entryComponents: [ PictureModalComponent ]
})
export class AppModule { }