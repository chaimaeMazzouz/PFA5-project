import { Component } from '@angular/core';
import { Auth, signInWithEmailAndPassword } from '@angular/fire/auth';
import { Router } from '@angular/router';  // Provide the correct path
import { AdminService } from '../services/admin.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
})
export class LoginComponent {
  email!: string;
  password!: string;
  errorMessage!: string;

  constructor(
    private router: Router,
    private auth: Auth,
    private adminService: AdminService  // Inject the AdminService
  ) { }

  login() {
    signInWithEmailAndPassword(this.auth, this.email, this.password)
      .then((userCredential) => {
        const user = userCredential.user;

        // Check if the user is an admin
        this.adminService.checkAdminStatus(user.uid)
          .subscribe((isAdmin) => {
            if (isAdmin) {
              // Navigate to the admin component
              this.router.navigate(['/admin']);
            } else {
              // Navigate to the client component
              this.router.navigate(['/client']);
            }
          }, (error) => {
            console.error("Error checking admin status:", error);
            // Handle the error as needed
          });
      })
      .catch((error) => {
        this.errorMessage = error.message;
      });
  }

  navigateTo(path: string) {
    this.router.navigate([`/${path}`]);
  }
}
