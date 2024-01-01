import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Demande } from '../models/demande';

@Injectable({
  providedIn: 'root',
})
export class DemandeService {
  private apiUrl = 'http:localhost:8888/demande-service/api/demandes';

  constructor(private http: HttpClient) {}

  getDemandes(): Observable<Demande[]> {
    return this.http.get<Demande[]>(this.apiUrl);
  }

  addDemande(demande: Demande): Observable<Demande> {
    return this.http.post<Demande>(this.apiUrl, demande);
  }

  deleteDemande(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`);
  }

  updateDemande(demande: Demande): Observable<Demande> {
    return this.http.put<Demande>(`${this.apiUrl}/${demande.id}`, demande);
  }
}
