import { EmailMessage } from './../models/EmailMessage';
import { NotificationService } from './../services/notification.service';
import { Component } from '@angular/core';
import { Demande, Etat } from '../models/demande.model';
import { DemandeService } from '../services/demande.service';
import { AdminService } from '../services/admin.service';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.css',
})
export class AdminComponent {
  demandes: Demande[] = [];
  selectedDemande: Demande = new Demande();
  emailMessage!: EmailMessage;

  constructor(
    private adminService: AdminService,
    private notificationService: NotificationService
  ) {}

  ngOnInit(): void {
    this.loadDemandes();
  }

  loadDemandes(): void {
    console.log('Loading demandes...');
    this.adminService.getAllDemandes().subscribe(
      (data) => {
        console.log('Loaded');
        console.log(data);
        this.demandes = data;
      },
      (error) => {
        console.error('Error fetching demandes', error);
      }
    );
  }

  selectDemande(demande: Demande): void {
    this.selectedDemande = { ...demande }; // Create a copy to edit
  }

  updateDemande(): void {
    if (this.selectedDemande) {
      this.adminService.updateDemande(this.selectedDemande).subscribe(
        (adminService) => {
          const index = this.demandes.findIndex(
            (d) => d.id === adminService.id
          );
          if (index !== -1) {
            this.demandes[index] = adminService;
          }
        },
        (error) => {
          console.error('Error updating demande', error);
        }
      );
    }
  }
}
