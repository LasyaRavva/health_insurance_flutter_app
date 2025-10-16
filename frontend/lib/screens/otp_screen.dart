import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../styles/colors.dart';
import '../widgets/loading_screen.dart';

class OtpScreen extends StatefulWidget {
  final String identifier;

  OtpScreen({required this.identifier});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _sendOtp();
  }

  Future<void> _sendOtp() async {
    setState(() => _isLoading = true);
    try {
      final response = await _apiService.sendOtp(widget.identifier);
      setState(() {
        _message = response['message'] ?? 'OTP sent successfully';
      });
    } catch (e) {
      setState(() {
        _message = 'Failed to send OTP';
      });
    }
    setState(() => _isLoading = false);
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final response = await _apiService.verifyOtp(
        widget.identifier,
        _otpController.text,
      );
      if (response['success'] == true) {
        // Store user id or token
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _message = response['message'] ?? 'Invalid OTP';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Verification failed';
      });
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _message.isEmpty) {
      return LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OTP sent to ${widget.identifier}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'Enter 6-digit OTP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
            SizedBox(height: 20),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: TextStyle(
                  color: _message.contains('success')
                      ? AppColors.success
                      : AppColors.error,
                ),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _verifyOtp,
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Verify OTP'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            TextButton(onPressed: _sendOtp, child: Text('Resend OTP')),
          ],
        ),
      ),
    );
  }
}
