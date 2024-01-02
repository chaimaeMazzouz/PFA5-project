export enum Etat {
  EN_COURS = 'EN_COURS',
  ACCEPTE = 'ACCEPTE',
  REJETE = 'REJETE',
}

export class Demande {
  id!: number;
  sujet: string;
  description: string;
  dateCreation: Date;
  etat: Etat;

  constructor(
    sujet: string = '',
    description: string = '',
    dateCreation: Date = new Date(),
    etat: Etat = Etat.EN_COURS
  ) {
    this.sujet = sujet;
    this.description = description;
    this.dateCreation = dateCreation;
    this.etat = etat;
  }
}
