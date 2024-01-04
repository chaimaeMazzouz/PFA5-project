class Demande {
  final int? id;
  final String sujet;
  final String description;
  final DateTime dateCreation;
  final String etat;

  Demande(
      {this.id,
      required this.sujet,
      required this.description,
      required this.dateCreation,
      required this.etat});

  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      id: json['id'],
      sujet: json['sujet'],
      description: json['description'],
      dateCreation: DateTime.parse(json['dateCreation']),
      etat: json['etat'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sujet': sujet,
        'description': description,
        'dateCreation': dateCreation.toIso8601String(),
        'etat': etat,
      };
}
