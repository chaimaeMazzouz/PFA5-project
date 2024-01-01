import { Component, OnInit } from '@angular/core';
import { Auth, User, authState } from '@angular/fire/auth';
import { Observable } from 'rxjs';

@Component({
  selector: 'app-client',
  templateUrl: './client.component.html',
  styleUrls: ['./client.component.css'],
})
export class ClientComponent implements OnInit {
  user$: Observable<User | null>;

  constructor(private auth: Auth) {
    this.user$ = authState(auth);
  }

  ngOnInit(): void {
    // Any additional initialization can go here
    this.user$.subscribe((user) => {
      if (user) {
        user.getIdToken().then((token) => {
          console.log(token);
        });
      } else {
        console.log('User is not logged in');
      }
    });
  }
}
