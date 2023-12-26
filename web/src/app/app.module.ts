import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { initializeApp, provideFirebaseApp } from '@angular/fire/app';
import { getAuth, provideAuth } from '@angular/fire/auth';

@NgModule({
  declarations: [AppComponent],
  imports: [
    BrowserModule,
    AppRoutingModule,
    provideFirebaseApp(() =>
      initializeApp({
        projectId: 'gestion-de-reservation-fb64e',
        appId: '1:738305311799:web:cdc5e2b3c122544ca6abb2',
        storageBucket: 'gestion-de-reservation-fb64e.appspot.com',
        apiKey: 'AIzaSyDncydkCpmgfdzNIETP_35QGw3SJ5c95B4',
        authDomain: 'gestion-de-reservation-fb64e.firebaseapp.com',
        messagingSenderId: '738305311799',
      })
    ),
    provideAuth(() => getAuth()),
  ],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
