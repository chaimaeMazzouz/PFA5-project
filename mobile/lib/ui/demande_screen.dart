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

  // Create controllers for text fields
  final TextEditingController _sujetController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _sujetController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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

  void _deleteDemande(int? id) async {
    setState(() {
      _isLoading = true;
    });
    await _demandeService.deleteDemande(id!);
    setState(() {
      _demandeList.removeWhere((demande) => demande.id == id);
      _isLoading = false;
    });
  }

  void _showAddDemandeDialog() {
    // Create a GlobalKey for the form
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Demande'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _sujetController,
                    decoration: InputDecoration(labelText: 'Subject'),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter a subject'
                          : null;
                    },
                  ),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter a description'
                          : null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a Snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Processing Data')),
                  );
                  // Create a new Demande object
                  Demande newDemande = Demande(
                    id: null,
                    sujet: _sujetController.text,
                    description: _descriptionController.text,
                    dateCreation: DateTime.now(),
                    etat: 'EN_COURS',
                  );
                  // Add the new Demande
                  _addOrUpdateDemande(newDemande, false);
                  _sujetController.clear();
                  _descriptionController.clear();
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
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
        onPressed: _showAddDemandeDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
