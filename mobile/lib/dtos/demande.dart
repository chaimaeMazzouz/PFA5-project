class Demande {
  final int id;
  final String sujet;
  final String description;
  String etat = 'EN_COURS';
  String email;
  final DateTime dateCreation; // Assuming you have a date field

  Demande({
    required this.id,
    required this.sujet,
    required this.description,
    required this.etat,
    required this.dateCreation,
    required this.email,
  });

  // Converts JSON Map to DemandeDTO
  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      id: json['id'],
      sujet: json['sujet'],
      description: json['description'],
      etat: json['etat'],
      email: json['email'],
      dateCreation: DateTime.parse(json['dateCreation']),
    );
  }

  // Converts DemandeDTO to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sujet': sujet,
      'description': description,
    };
  }
}
