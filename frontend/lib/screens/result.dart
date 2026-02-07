import 'package:flutter/material.dart';
import 'package:symptom_checker/models/result_model.dart';
import 'clinic_suggestion_screen.dart';

class ResultScreen extends StatefulWidget {
  final DiagnosisResult result;

  const ResultScreen({super.key, required this.result});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Results'),
        elevation: 0,
      ),
<<<<<<< HEAD
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Confidence Score Display
              if (result.confidence > 0)
                Card(
                  elevation: 4,
                  color: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Analysis Confidence',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: result.confidence,
                                  minHeight: 10,
                                  backgroundColor: Colors.grey[700],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    result.confidence > 0.8
                                        ? Colors.green
                                        : Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${(result.confidence * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Probable Condition(s):',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ...result.conditions.map((condition) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                condition,
                                style: const TextStyle(fontSize: 16),
=======
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Analysis Complete',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Based on your symptoms, here are the possible conditions',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: 24),
              ...widget.result.conditions.map((condition) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: ConditionCard(condition: condition),
                        );
                      },
                    ),
                  )),
              const SizedBox(height: 24),
              if (widget.result.urgentCare) ...[
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Card(
                        color: Colors.red.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.red, width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Immediate medical attention recommended',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Please seek professional medical care as soon as possible',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.red,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
              Text(
                'Recommendations',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: widget.result.recommendations.map((recommendation) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                recommendation,
                                style: Theme.of(context).textTheme.bodyMedium,
>>>>>>> vikas
                              ),
                            ),
                          ],
                        ),
<<<<<<< HEAD
                      )),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            'Severity: ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: result.color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              result.severityText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
=======
                      );
                    }).toList(),
>>>>>>> vikas
                  ),
                ),
              ),
              const SizedBox(height: 24),
<<<<<<< HEAD
              const Text(
                'Guidance:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Please consult with a healthcare professional for proper diagnosis and treatment. This analysis is for informational purposes only.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[300]),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'View Nearby Clinics',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClinicSuggestionScreen(clinics: result.clinics ?? []),
                    ),
                  );
                },
              ),
            ],
          ),
=======
              if (!widget.result.urgentCare) ...[
                Text(
                  'First Aid Guidance',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        _buildFirstAidItem(
                          'Rest and stay hydrated',
                          'Get plenty of rest and drink fluids regularly',
                        ),
                        _buildFirstAidItem(
                          'Monitor symptoms',
                          'Keep track of your symptoms and their progression',
                        ),
                        _buildFirstAidItem(
                          'Over-the-counter medications',
                          'Use appropriate OTC medications for symptom relief',
                        ),
                        _buildFirstAidItem(
                          'Seek medical advice',
                          'Consult a healthcare professional if symptoms persist',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClinicSuggestionScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.local_hospital_outlined),
                  label: const Text('Find Nearby Clinics'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstAidItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.medical_services_outlined,
            color: Color(0xFF0F4C5C),
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ConditionCard extends StatelessWidget {
  final Condition condition;

  const ConditionCard({super.key, required this.condition});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    condition.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SeverityBadge(severity: condition.severity),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${(condition.probability * 100).round()}% probability',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              condition.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
>>>>>>> vikas
        ),
      ),
    );
  }
<<<<<<< HEAD
=======
}

class SeverityBadge extends StatelessWidget {
  final Severity severity;

  const SeverityBadge({super.key, required this.severity});

  Color get _color {
    switch (severity) {
      case Severity.mild:
        return Colors.green;
      case Severity.moderate:
        return Colors.orange;
      case Severity.severe:
        return Colors.red;
    }
  }

  String get _severityText {
    switch (severity) {
      case Severity.mild:
        return 'Mild';
      case Severity.moderate:
        return 'Moderate';
      case Severity.severe:
        return 'Severe';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.2),
        border: Border.all(color: _color, width: 2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        _severityText,
        style: TextStyle(
          color: _color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
>>>>>>> vikas
}