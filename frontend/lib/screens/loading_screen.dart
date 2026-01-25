import 'package:flutter/material.dart';
import 'package:symptom_checker/models/user_model.dart';
import 'package:symptom_checker/models/symptom_model.dart';
import 'package:symptom_checker/services/api_service.dart';
import 'result.dart';

class LoadingScreen extends StatefulWidget {
  final User user;
  final SymptomData symptomData;

  const LoadingScreen({super.key, required this.user, required this.symptomData});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _analyzeSymptoms();
  }

  Future<void> _analyzeSymptoms() async {
    final apiService = ApiService();
    final result = await apiService.analyzeSymptoms(
      widget.symptomData.selectedSymptoms,
      widget.symptomData.additionalSymptoms,
    );
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(result: result),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text(
              'Analyzing symptoms using AI...',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}