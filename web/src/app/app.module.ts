import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { initializeApp, provideFirebaseApp } from '@angular/fire/app';
import { getAuth, provideAuth } from '@angular/fire/auth';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { ForgotPasswordComponent } from './forgot-password/forgot-password.component';
import { FormsModule } from '@angular/forms';
import { RouterModule, Routes } from '@angular/router';

const routes: Routes = [
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'forgot-password', component: ForgotPasswordComponent },
  // Add other routes here
  { path: '', redirectTo: '/login', pathMatch: 'full' }, // Default route
];

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
    ForgotPasswordComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    RouterModule.forRoot(routes),
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
  exports: [RouterModule],
})
export class AppModule {}
