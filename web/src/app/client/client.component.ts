import { Component, OnInit } from '@angular/core';
import { DemandeService } from '../services/demande.service';
import { Demande, Etat } from '../models/demande.model';

@Component({
  selector: 'app-client',
  templateUrl: './client.component.html',
  styleUrls: ['./client.component.scss'],
})
export class ClientComponent implements OnInit {
  demandes: Demande[] = [];
  selectedDemande: Demande = new Demande();

  constructor(private demandeService: DemandeService) {}

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

  addDemande(formValues: { sujet: string; description: string }): void {
    const newDemande = new Demande(
      formValues.sujet,
      formValues.description,
      new Date(), // Set the creation date to now
      Etat.EN_COURS
    );

    this.demandeService.createDemande(newDemande).subscribe(
      (addedDemande) => {
        this.demandes.push(addedDemande);
      },
      (error) => {
        console.error('Error adding demande', error);
      }
    );
  }

  deleteDemande(demandeId: number): void {
    this.demandeService.deleteDemande(demandeId).subscribe(
      () => {
        this.demandes = this.demandes.filter((d) => d.id !== demandeId);
      },
      (error) => {
        console.error('Error deleting demande', error);
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
        },
        (error) => {
          console.error('Error updating demande', error);
        }
      );
    }
  }
}
