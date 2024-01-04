import 'package:flutter/material.dart';
import 'package:mobile/models/Demande.dart';
import 'package:mobile/services/demande_service.dart';

class DemandeScreen extends StatefulWidget {
  const DemandeScreen({super.key});

  @override
  _DemandeScreenState createState() => _DemandeScreenState();
}

class _DemandeScreenState extends State<DemandeScreen> {
  final DemandeService _demandeService = DemandeService();
  List<Demande> _demandeList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDemandes();
  }

  void _fetchDemandes() async {
    try {
      List<Demande> demandes = await _demandeService.getAllDemandes();
      setState(() {
        _demandeList = demandes;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void _addOrUpdateDemande(Demande demande, bool isUpdate) async {
    Demande result;
    setState(() {
      _isLoading = true;
    });

    if (isUpdate) {
      result = await _demandeService.updateDemande(demande);
    } else {
      result = await _demandeService.createDemande(demande);
    }

    if (result != null) {
      setState(() {
        if (isUpdate) {
          int index = _demandeList.indexWhere((d) => d.id == demande.id);
          if (index != -1) {
            _demandeList[index] = result;
          }
        } else {
          _demandeList.add(result);
        }
        _isLoading = false;
      });
    } else {}
  }

  void _deleteDemande(int id) async {
    setState(() {
      _isLoading = true;
    });
    await _demandeService.deleteDemande(id);
    setState(() {
      _demandeList.removeWhere((demande) => demande.id == id);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demandes'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _demandeList.isEmpty
              ? Center(child: Text('No demandes found.'))
              : ListView.builder(
                  itemCount: _demandeList.length,
                  itemBuilder: (context, index) {
                    Demande demande = _demandeList[index];
                    return ListTile(
                      title: Text(demande.sujet),
                      subtitle: Text(demande.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteDemande(demande.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show add dialog or navigate to add screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
