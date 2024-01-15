import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class AdminService {
  final String apiUrl =
      'https://e148-196-89-158-31.ngrok-free.app/demande-service/api/admins';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _getIdToken() async {
    return await _auth.currentUser!.getIdToken() ?? "";
  }

  Future<bool> checkAdminStatus() async {
    String token = await _getIdToken();
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as bool;
    } else {
      throw Exception('Failed to check admin status');
    }
  }

  Future<List<dynamic>> getAllDemandes() async {
    String token = await _getIdToken();
    final response = await http.get(
      Uri.parse('$apiUrl/all'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load demandes');
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
}
