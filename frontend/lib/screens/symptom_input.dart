import 'package:flutter/material.dart';
import 'package:symptom_checker/models/user_model.dart';
import 'package:symptom_checker/models/symptom_model.dart';
import 'package:symptom_checker/widgets/custom_button.dart';
import 'package:symptom_checker/widgets/symptom_checkbox.dart';
import 'loading_screen.dart';

class SymptomInputScreen extends StatefulWidget {
  final User user;

  const SymptomInputScreen({super.key, required this.user});

  @override
  State<SymptomInputScreen> createState() => _SymptomInputScreenState();
}

class _SymptomInputScreenState extends State<SymptomInputScreen> {
  late List<Symptom> symptoms;
  final _additionalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    symptoms = [
      Symptom(name: 'Fever'),
      Symptom(name: 'Cough'),
      Symptom(name: 'Headache'),
      Symptom(name: 'Chest Pain'),
      Symptom(name: 'Breathing Difficulty'),
      Symptom(name: 'Fatigue'),
      Symptom(name: 'Nausea'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Symptoms'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select all symptoms you are experiencing:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: symptoms.map((symptom) {
                  return SymptomCheckbox(
                    symptom: symptom,
                    onChanged: (value) {
                      setState(() {
                        symptom.isSelected = value ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _additionalController,
              decoration: const InputDecoration(
                labelText: 'Additional symptoms (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Analyze Symptoms',
              onPressed: () {
                final selectedSymptoms = symptoms.where((s) => s.isSelected).toList();
                if (selectedSymptoms.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select at least one symptom')),
                  );
                  return;
                }
                final symptomData = SymptomData(
                  symptoms: selectedSymptoms,
                  additionalSymptoms: _additionalController.text.isEmpty ? null : _additionalController.text,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoadingScreen(
                      user: widget.user,
                      symptomData: symptomData,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _additionalController.dispose();
    super.dispose();
  }
}