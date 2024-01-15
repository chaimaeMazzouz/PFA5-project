import 'package:flutter/material.dart';
import 'package:mobile/dtos/demande.dart';
import 'package:mobile/services/demande_service.dart';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final DemandeService _demandeService = DemandeService();
  List<Demande> _demandes = [];

  @override
  void initState() {
    super.initState();
    _loadDemandes();
  }

  Future<void> _loadDemandes() async {
    try {
      final demandesData = await _demandeService.getAllDemandes();
      setState(() {
        _demandes = demandesData.map((data) => Demande.fromJson(data)).toList();
      });
    } catch (e) {
// Handle error
    }
  }

  Future<void> _addDemande() async {
// Add logic to add a new demande
// For simplicity, using dummy data here
    Map<String, dynamic> newDemandeData = {
      'sujet': 'New Sujet',
      'description': 'New Description',
    };
    try {
      final newDemande = await _demandeService.createDemande(newDemandeData);
      setState(() {
        _demandes.add(Demande.fromJson(newDemande));
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _editDemande(Demande demande) async {
// Add logic to edit an existing demande
// For simplicity, using dummy data here
    Map<String, dynamic> updatedDemandeData = {
      'sujet': 'Updated Sujet',
      'description': 'Updated Description',
    };
    try {
      final updatedDemande = await _demandeService.updateDemande(
          demande.id ?? 0, updatedDemandeData);
      setState(() {
        int index = _demandes.indexWhere((d) => d.id == demande.id);
        if (index != -1) {
          _demandes[index] = Demande.fromJson(updatedDemande);
        }
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _deleteDemande(int id) async {
    try {
      await _demandeService.deleteDemande(id);
      setState(() {
        _demandes.removeWhere((demande) => demande.id == id);
      });
    } catch (e) {
// Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Demandes'),
      ),
      body: ListView.builder(
        itemCount: _demandes.length,
        itemBuilder: (context, index) {
          final demande = _demandes[index];
          return ListTile(
            title: Text(demande.sujet),
            subtitle: Text(demande.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editDemande(demande),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteDemande(demande.id ?? 0),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDemande,
        child: Icon(Icons.add),
      ),
    );
  }
}
