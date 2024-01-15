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
  TextEditingController _sujetController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

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
        print("_demandes : " + _demandes.toString());
      });
    } catch (e) {
      print("error" + e.toString());
    }
  }

  Future<void> _showDemandeDialog({Demande? demande}) async {
    final isEditing = demande != null;
    _sujetController.text = isEditing ? demande!.sujet : '';
    _descriptionController.text = isEditing ? demande!.description : '';

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Demande' : 'Create Demande'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _sujetController,
                  decoration: InputDecoration(labelText: 'Sujet'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(isEditing ? 'Save Changes' : 'Create'),
              onPressed: () async {
                if (isEditing) {
                  // Edit existing demande
                  await _editDemande(demande!);
                } else {
                  // Create a new demande
                  await _addDemande();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _addDemande() async {
    Map<String, dynamic> newDemandeData = {
      'sujet': _sujetController.text,
      'description': _descriptionController.text,
      'etat': 'EN_COURS'
    };

    try {
      final newDemande = await _demandeService.createDemande(newDemandeData);
      setState(() {
        _demandes.add(Demande.fromJson(newDemande));
      });
      _showMessageSnackBar(context, "Demande created successfully");
    } catch (e) {
      _showErrorSnackBar(context, e.toString() ?? 'Failed to create demande');
    }
  }

  Future<void> _editDemande(Demande demande) async {
    Map<String, dynamic> updatedDemandeData = {
      'sujet': _sujetController.text,
      'description': _descriptionController.text,
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
      _showMessageSnackBar(context, "Demande edited successfully");
    } catch (e) {
      _showErrorSnackBar(context, e.toString() ?? 'Failed to create demande');
    }
  }

  Future<void> _deleteDemande(int id) async {
    try {
      await _demandeService.deleteDemande(id);
      setState(() {
        _demandes.removeWhere((demande) => demande.id == id);
      });
      _showMessageSnackBar(context, "Demande deleted successfully");
    } catch (e) {
      // Handle error
    }
  }

  void _showMessageSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                  onPressed: () => _showDemandeDialog(demande: demande),
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
        onPressed: () => _showDemandeDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
