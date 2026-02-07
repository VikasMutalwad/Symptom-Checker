import 'package:flutter/material.dart';
import 'package:symptom_checker/models/clinic_model.dart';

class ClinicSuggestionScreen extends StatefulWidget {
  const ClinicSuggestionScreen({super.key});

  @override
  State<ClinicSuggestionScreen> createState() => _ClinicSuggestionScreenState();
}

class _ClinicSuggestionScreenState extends State<ClinicSuggestionScreen>
    with SingleTickerProviderStateMixin {
  late List<Clinic> clinics;
  late AnimationController _animationController;
  late List<Animation<double>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _loadMockClinics();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimations = List.generate(
      5,
      (index) => Tween<double>(
        begin: 50.0,
        end: 0.0,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadMockClinics() {
    clinics = const [
      Clinic(
        name: 'City General Hospital',
        distance: '2.3 km',
        address: '123 Main St, Downtown',
        phone: '+1 (555) 123-4567',
      ),
      Clinic(
        name: 'Medical Center Plus',
        distance: '3.1 km',
        address: '456 Health Ave, Midtown',
        phone: '+1 (555) 234-5678',
      ),
      Clinic(
        name: 'Care Clinic',
        distance: '4.2 km',
        address: '789 Wellness Blvd, Uptown',
        phone: '+1 (555) 345-6789',
      ),
      Clinic(
        name: 'Family Health Center',
        distance: '5.0 km',
        address: '321 Care Lane, Suburb',
        phone: '+1 (555) 456-7890',
      ),
      Clinic(
        name: 'Emergency Care Unit',
        distance: '6.5 km',
        address: '654 Urgent St, City Center',
        phone: '+1 (555) 567-8901',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Clinics'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended Clinics',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find healthcare facilities near you',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: clinics.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _slideAnimations[index],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _slideAnimations[index].value),
                        child: Opacity(
                          opacity: (1.0 - _slideAnimations[index].value / 50.0).clamp(0.0, 1.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ClinicCard(clinic: clinics[index]),
                          ),
                        ),
                      );
                    },
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

class ClinicCard extends StatelessWidget {
  final Clinic clinic;

  const ClinicCard({super.key, required this.clinic});

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
                const Icon(
                  Icons.local_hospital_outlined,
                  size: 32,
                  color: Color(0xFF0F4C5C),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clinic.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            clinic.distance,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Calling ${clinic.name}'),
                        action: SnackBarAction(
                          label: 'Call',
                          onPressed: () {
                            // Mock call action
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.call_outlined),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.1),
                    foregroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              clinic.address,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              clinic.phone,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}