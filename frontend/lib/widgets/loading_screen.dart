import 'package:flutter/material.dart';
import '../styles/colors.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
            ),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
