import { Component, OnInit } from '@angular/core';
import { DemandeService } from '../services/demande.service';
import { Demande, Etat } from '../models/demande'; // Import your Demande model and Etat enum here

@Component({
  selector: 'app-client',
  templateUrl: './client.component.html',
  styleUrls: ['./client.component.scss'],
})
export class ClientComponent implements OnInit {
  demandes: Demande[] = [];
  selectedDemande: Demande | null = null;

  constructor(private demandeService: DemandeService) {}

  ngOnInit(): void {
    this.loadDemandes();
  }

  loadDemandes(): void {
    this.demandeService.getDemandes().subscribe(
      (data) => {
        this.demandes = data;
      },
      (error) => {
        console.error('Error fetching demandes', error);
      }
    );
  }

  addDemande(formValues: any): void {
    const newDemande = new Demande();
    newDemande.sujet = formValues.sujet;
    newDemande.description = formValues.description;
    // Assuming the default state for a new demande is 'En cours'
    newDemande.etat = Etat.En_cours;
    newDemande.date_creation = new Date(); // Set the creation date to now

    this.demandeService.addDemande(newDemande).subscribe(
      (addedDemande) => {
        this.demandes.push(addedDemande);
      },
      (error) => {
        console.error('Error adding demande', error);
      }
    );
  }

  deleteDemande(demande: Demande): void {
    this.demandeService.deleteDemande(demande.id).subscribe(
      () => {
        this.demandes = this.demandes.filter((d) => d.id !== demande.id);
      },
      (error) => {
        console.error('Error deleting demande', error);
      }
    );
  }

  selectDemande(demande: Demande): void {
    this.selectedDemande = { ...demande }; // Create a copy to edit
  }

  updateDemande(formValues: any): void {
    if (this.selectedDemande) {
      this.selectedDemande.sujet = formValues.sujet;
      this.selectedDemande.description = formValues.description;
      this.selectedDemande.etat = formValues.etat;

      this.demandeService.updateDemande(this.selectedDemande).subscribe(
        (updatedDemande) => {
          const index = this.demandes.findIndex(
            (d) => d.id === updatedDemande.id
          );
          if (index !== -1) {
            this.demandes[index] = updatedDemande;
          }
          this.selectedDemande = null; // Reset the selected demande
        },
        (error) => {
          console.error('Error updating demande', error);
        }
      );
    }
  }
}
