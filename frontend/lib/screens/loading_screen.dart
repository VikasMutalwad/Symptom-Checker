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
  String _status = 'Connecting to backend...';

  @override
  void initState() {
    super.initState();
    _analyzeSymptoms();
  }

  Future<void> _analyzeSymptoms() async {
    try {
      _updateStatus('Sending symptoms to AI model...');
      
      final apiService = ApiService();
      final result = await apiService.analyzeSymptoms(
        widget.symptomData.selectedSymptoms,
        widget.symptomData.additionalSymptoms,
      );
      
      _updateStatus('Fetching nearby clinics...');
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(result: result),
          ),
        );
      }
    } catch (e) {
      _updateStatus('Error: ${e.toString()}');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _updateStatus(String newStatus) {
    if (mounted) {
      setState(() {
        _status = newStatus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              strokeWidth: 3,
            ),
            const SizedBox(height: 24),
            const Text(
              'Analyzing symptoms using AI...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                _status,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                border: Border.all(color: Colors.green, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'Connected to Real API',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
