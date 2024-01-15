class Demande {
  final int id;
  final String sujet;
  final String description;
  String etat;
  final DateTime dateCreation; // Assuming you have a date field

  Demande({
    required this.id,
    required this.sujet,
    required this.description,
    required this.etat,
    required this.dateCreation,
  });

  // Converts JSON Map to DemandeDTO
  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      id: json['id'],
      sujet: json['sujet'],
      description: json['description'],
      etat: json['etat'],
      dateCreation: DateTime.parse(json['dateCreation']),
    );
  }

  // Converts DemandeDTO to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sujet': sujet,
      'description': description,
      'etat': etat,
      'dateCreation':
          dateCreation.toIso8601String(), // Format DateTime as ISO-8601 string
    };
  }
}
