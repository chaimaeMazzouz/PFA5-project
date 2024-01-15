import 'package:flutter/material.dart';
import 'package:mobile/dtos/demande.dart';
import 'package:mobile/services/admin_service.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final AdminService _adminService = AdminService();
  List<Demande> _demandes = [];
  Demande? _selectedDemande;

  @override
  void initState() {
    super.initState();
    _loadDemandes();
  }

  Future<void> _loadDemandes() async {
    try {
      final demandesData = await _adminService.getAllDemandes();
      setState(() {
        _demandes = demandesData.map((data) => Demande.fromJson(data)).toList();
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _updateDemande() async {
    if (_selectedDemande != null) {
      try {
        await _adminService.updateDemande(
            _selectedDemande!.id ?? 0, _selectedDemande!.toJson());
        setState(() {
          // Update the list item with the new data
        });
      } catch (e) {
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Demandes')),
      body: _demandes.isEmpty
          ? Center(child: Text('No demandes found.'))
          : ListView.builder(
              itemCount: _demandes.length,
              itemBuilder: (context, index) {
                final demande = _demandes[index];
                return ListTile(
                  title: Text(demande.sujet),
                  subtitle: Text(demande.description),
                  trailing: DropdownButton<String>(
                    value: demande.etat,
                    items: <String>['EN_COURS', 'ACCEPTE', 'REJETE']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        demande.etat = newValue!;
                        _selectedDemande = demande;
                      });
                      _updateDemande();
                    },
                  ),
                );
              },
            ),
    );
  }
}
