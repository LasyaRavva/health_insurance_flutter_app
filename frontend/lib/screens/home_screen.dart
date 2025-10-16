import 'package:flutter/material.dart';
import '../styles/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(
              context,
              'Insurance Card',
              Icons.credit_card,
              '/insurance_card',
              AppColors.primaryGreen,
            ),
            _buildFeatureCard(
              context,
              'Check Coverage',
              Icons.shield,
              '/coverage',
              AppColors.secondaryYellow,
            ),
            _buildFeatureCard(
              context,
              'Submit Claim',
              Icons.camera_alt,
              '/claim',
              AppColors.primaryTeal,
            ),
            _buildFeatureCard(
              context,
              'Find Hospitals',
              Icons.local_hospital,
              '/hospitals',
              AppColors.secondaryOrange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    String route,
    Color color,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [color.withAlpha((0.7 * 255).toInt()), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
