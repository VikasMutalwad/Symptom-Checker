import 'package:flutter/material.dart';
import 'package:symptom_checker/models/user_model.dart';
import 'package:symptom_checker/models/symptom_model.dart';
import 'package:symptom_checker/models/result_model.dart';
import 'result.dart';

class LoadingScreen extends StatefulWidget {
  final User user;
  final SymptomData symptomData;

  const LoadingScreen({super.key, required this.user, required this.symptomData});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

<<<<<<< HEAD
class _LoadingScreenState extends State<LoadingScreen> {
  String _status = 'Connecting to backend...';
=======
class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
>>>>>>> vikas

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _analyzeSymptoms();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _analyzeSymptoms() async {
<<<<<<< HEAD
    try {
      _updateStatus('Sending symptoms to AI model...');
      
      final apiService = ApiService();
      final result = await apiService.analyzeSymptoms(
        widget.symptomData.selectedSymptoms,
        widget.symptomData.additionalSymptoms,
=======
    // Simulate AI analysis delay
    await Future.delayed(const Duration(seconds: 3));

    // Mock result based on symptoms
    final mockResult = _generateMockResult();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(result: mockResult),
        ),
>>>>>>> vikas
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

  DiagnosisResult _generateMockResult() {
    final selectedSymptoms = widget.symptomData.selectedSymptoms;

    // Simple mock logic based on symptoms
    if (selectedSymptoms.contains('Fever') && selectedSymptoms.contains('Cough')) {
      return const DiagnosisResult(
        conditions: [
          Condition(
            name: 'Common Cold',
            probability: 0.75,
            severity: Severity.mild,
            description: 'A viral infection of the upper respiratory tract.',
          ),
          Condition(
            name: 'Influenza',
            probability: 0.60,
            severity: Severity.moderate,
            description: 'A contagious respiratory illness caused by influenza viruses.',
          ),
        ],
        recommendations: [
          'Rest and stay hydrated',
          'Take over-the-counter cold medications',
          'Use a humidifier to ease congestion',
        ],
        urgentCare: false,
      );
    } else if (selectedSymptoms.contains('Chest Pain') ||
               selectedSymptoms.contains('Breathing Difficulty')) {
      return const DiagnosisResult(
        conditions: [
          Condition(
            name: 'Possible Cardiac Issue',
            probability: 0.85,
            severity: Severity.severe,
            description: 'Chest pain and breathing difficulties require immediate medical attention.',
          ),
        ],
        recommendations: [
          'Seek immediate medical attention',
          'Call emergency services if symptoms worsen',
          'Do not ignore chest pain',
        ],
        urgentCare: true,
      );
    } else {
      return const DiagnosisResult(
        conditions: [
          Condition(
            name: 'General Viral Infection',
            probability: 0.70,
            severity: Severity.mild,
            description: 'Common symptoms that may resolve with rest and home care.',
          ),
        ],
        recommendations: [
          'Rest and monitor symptoms',
          'Stay hydrated and eat nutritious foods',
          'Consider over-the-counter pain relievers if needed',
          'Contact healthcare provider if symptoms persist or worsen',
        ],
        urgentCare: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
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
=======
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1F3C88), Color(0xFF0F4C5C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 4,
                        ),
                      ),
                      child: const Icon(
                        Icons.monitor_heart_outlined,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              Text(
                'Analyzing symptoms using AI...',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'This may take a few seconds',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const SizedBox(
                width: 200,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
>>>>>>> vikas
        ),
      ),
    );
  }
}
