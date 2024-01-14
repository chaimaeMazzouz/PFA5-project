import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AdminService {

  private readonly API_URL = '/api/admins';

  constructor(private httpClient: HttpClient) { }

  checkAdminStatus(userId: string): Observable<boolean> {
    return this.httpClient.get<boolean>(`${this.API_URL}`, { params: { userId } });
  }
}
