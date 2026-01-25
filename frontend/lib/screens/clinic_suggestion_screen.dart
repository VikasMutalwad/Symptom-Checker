import 'package:flutter/material.dart';
import 'package:symptom_checker/models/clinic_model.dart';

class ClinicSuggestionScreen extends StatefulWidget {
  final List<Clinic> clinics;
  
  const ClinicSuggestionScreen({super.key, this.clinics = const []});

  @override
  State<ClinicSuggestionScreen> createState() => _ClinicSuggestionScreenState();
}

class _ClinicSuggestionScreenState extends State<ClinicSuggestionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Clinics'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
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
              child: widget.clinics.isEmpty
                  ? const Center(
                      child: Text('No clinics found in your area'),
                    )
                  : ListView.builder(
                      itemCount: widget.clinics.length,
                      itemBuilder: (context, index) {
                        final clinic = widget.clinics[index];
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
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Distance: ${clinic.distance}'),
                                if (clinic.rating != null)
                                  Text('Rating: ${clinic.rating}★'),
                              ],
                            ),
                            trailing: ElevatedButton.icon(
                              onPressed: () {
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