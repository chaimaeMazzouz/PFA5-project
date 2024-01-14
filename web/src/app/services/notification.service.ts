import { EmailMessage } from './../models/EmailMessage';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Auth } from '@angular/fire/auth';
import { Observable, from, map, switchMap, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class NotificationService {

  private apiUrl = 'http://localhost:8888/notification-service/api/send-text'; // Use your actual URL

  constructor(private http: HttpClient, private auth: Auth) {}

  private getHeaders(): Observable<HttpHeaders> {
    return this.auth.currentUser
      ? from(this.auth.currentUser.getIdToken()).pipe(
          map((token) =>
            new HttpHeaders().set('Authorization', `Bearer ${token}`)
          )
        )
      : throwError(() => new Error('User is not logged in'));
  }

  sendNotification( emailMessage : EmailMessage): Observable<EmailMessage> {
    return this.getHeaders().pipe(
      switchMap((headers) =>
        this.http.post<EmailMessage>(this.apiUrl, emailMessage, { headers })
      )
    );
  }
}
