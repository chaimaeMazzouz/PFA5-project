import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, from, throwError } from 'rxjs';
import { map, switchMap } from 'rxjs/operators';
import { Auth } from '@angular/fire/auth';
import { Demande } from '../models/demande.model'; // Make sure to have a 'Demande' model

@Injectable({
  providedIn: 'root',
})
export class DemandeService {
  private apiUrl = 'http://localhost:8888/demande-service/api/demandes'; // Use your actual URL

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

  getAllDemandes(): Observable<Demande[]> {
    return this.getHeaders().pipe(
      switchMap((headers) => this.http.get<Demande[]>(this.apiUrl, { headers }))
    );
  }

  createDemande(demande: Demande): Observable<Demande> {
    return this.getHeaders().pipe(
      switchMap((headers) =>
        this.http.post<Demande>(this.apiUrl, demande, { headers })
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

  deleteDemande(demandeId: number): Observable<any> {
    return this.getHeaders().pipe(
      switchMap((headers) =>
        this.http.delete(`${this.apiUrl}/${demandeId}`, { headers })
      )
    );
  }
}
