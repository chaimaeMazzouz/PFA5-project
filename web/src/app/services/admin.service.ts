import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, from, map, switchMap, throwError } from 'rxjs';
import { Auth } from '@angular/fire/auth';
import { Demande } from '../models/demande.model';

@Injectable({
  providedIn: 'root',
})
export class AdminService {
  private readonly apiUrl = 'http://localhost:8888/demande-service/api/admins';

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
  checkAdminStatus(): Observable<boolean> {
    return this.getHeaders().pipe(
      switchMap((headers) => this.http.get<boolean>(this.apiUrl, { headers }))
    );
  }
  getAllDemandes(): Observable<Demande[]> {
    return this.getHeaders().pipe(
      switchMap((headers) =>
        this.http.get<Demande[]>(`${this.apiUrl}/all`, { headers })
      )
    );
  }
  updateDemande(demande: Demande): Observable<Demande> {
    return this.getHeaders().pipe(
      switchMap((headers) =>
        this.http.put<Demande>(`${this.apiUrl}/${demande.id}`, demande, {
          headers,
        })
      )
    );
  }
}
