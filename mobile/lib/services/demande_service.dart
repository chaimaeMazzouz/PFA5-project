import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class DemandeService {
  final String apiUrl =
      'https://e148-196-89-158-31.ngrok-free.app/demande-service/api/demandes';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _getIdToken() async {
    return await _auth.currentUser!.getIdToken() ?? "";
  }

  Future<List<dynamic>> getAllDemandes() async {
    String token = await _getIdToken();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load demandes');
    }
  }

  Future<dynamic> createDemande(Map<String, dynamic> demande) async {
    String token = await _getIdToken();
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(demande),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create demande');
    }
  }

  Future<dynamic> updateDemande(int id, Map<String, dynamic> demande) async {
    String token = await _getIdToken();
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(demande),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update demande');
    }
  }

  Future<void> deleteDemande(int id) async {
    String token = await _getIdToken();
    final response = await http.delete(
      Uri.parse('$apiUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete demande');
    }
  }
}
