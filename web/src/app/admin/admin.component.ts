import { EmailMessage } from './../models/EmailMessage';
import { NotificationService } from './../services/notification.service';
import { Component } from '@angular/core';
import { Demande, Etat } from '../models/demande.model';
import { DemandeService } from '../services/demande.service';

@Component({
  selector: 'app-admin',
  templateUrl: './admin.component.html',
  styleUrl: './admin.component.css'
})
export class AdminComponent {
  demandes: Demande[] = [];
  etats!: Etat;
  selectedDemande: Demande = new Demande();
  emailMessage!: EmailMessage;

  constructor(private demandeService: DemandeService, private notificationService: NotificationService) {}

  ngOnInit(): void {
    this.loadDemandes();
  }

  loadDemandes(): void {
    this.demandeService.getAllDemandes().subscribe(
      (data) => {
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
      this.demandeService.updateDemande(this.selectedDemande).subscribe(
        (updatedDemande) => {
          const index = this.demandes.findIndex(
            (d) => d.id === updatedDemande.id
          );
          if (index !== -1) {
            this.demandes[index] = updatedDemande;
          }
          this.notificationService.sendNotification(this.emailMessage).subscribe();
        },
        (error) => {
          console.error('Error updating demande', error);
        }
      );
    }
  }
}