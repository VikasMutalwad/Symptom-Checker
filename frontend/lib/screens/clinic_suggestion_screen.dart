import 'package:flutter/material.dart';
import 'package:symptom_checker/models/clinic_model.dart';
import 'package:symptom_checker/services/api_service.dart';

class ClinicSuggestionScreen extends StatefulWidget {
  const ClinicSuggestionScreen({super.key});

  @override
  State<ClinicSuggestionScreen> createState() => _ClinicSuggestionScreenState();
}

class _ClinicSuggestionScreenState extends State<ClinicSuggestionScreen> {
  List<Clinic> clinics = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClinics();
  }

  Future<void> _loadClinics() async {
    final apiService = ApiService();
    final loadedClinics = await apiService.getNearbyClinics();
    setState(() {
      clinics = loadedClinics;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Clinics'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recommended Clinics Near You:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: clinics.length,
                      itemBuilder: (context, index) {
                        final clinic = clinics[index];
                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(
                              clinic.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Distance: ${clinic.distance}'),
                            trailing: ElevatedButton.icon(
                              onPressed: () {
                                // Mock call action
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Calling ${clinic.name}')),
                                );
                              },
                              icon: const Icon(Icons.call),
                              label: const Text('Call'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}