export class Demande {
  id!: number;
  sujet!: string;
  description!: string;
  date_creation!: Date;
  etat!: Etat;
}

export enum Etat {
  En_cours = 'En_cours',
  Accepte = 'Accepte',
  Rejete = 'Rejete',
}
