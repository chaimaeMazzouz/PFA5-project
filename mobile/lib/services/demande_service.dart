import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile/models/Demande.dart';

class DemandeService {
  final String apiUrl = 'http://localhost:8888/demande-service/api/demandes';

  Future<List<Demande>> getAllDemandes() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Demande.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load demandes');
    }
  }

  Future<Demande> createDemande(Demande demande) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(demande.toJson()),
    );
    if (response.statusCode == 201) {
      return Demande.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create a demande');
    }
  }

  Future<Demande> updateDemande(Demande demande) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${demande.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(demande.toJson()),
    );
    if (response.statusCode == 200) {
      return Demande.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update the demande');
    }
  }

  Future<void> deleteDemande(int demandeId) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/$demandeId'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete the demande');
    }
  }
}
