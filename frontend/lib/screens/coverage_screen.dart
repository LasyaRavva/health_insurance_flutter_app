import 'package:flutter/material.dart';
import '../styles/colors.dart';

class CoverageScreen extends StatelessWidget {
  final List<String> coverages = [
    'Hospitalization (up to ₹5,00,000)',
    'Outpatient Care (₹50,000 per year)',
    'Dental Care (₹25,000 per year)',
    'Maternity Care (₹2,00,000)',
    'Emergency Services',
    'Ambulance Services',
    'Prescription Drugs',
    'Preventive Care',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What\'s Covered'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: ListView.builder(
        itemCount: coverages.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.check_circle, color: AppColors.success),
              title: Text(coverages[index], style: TextStyle(fontSize: 16)),
            ),
          );
        },
      ),
    );
  }
}
