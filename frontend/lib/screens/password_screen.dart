import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../styles/colors.dart';
import '../widgets/loading_screen.dart';

class PasswordScreen extends StatefulWidget {
  final String identifier;

  PasswordScreen({required this.identifier});

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String _message = '';

  Future<void> _login() async {
    if (_passwordController.text.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      final response = await _apiService.login(
        widget.identifier,
        _passwordController.text,
      );
      if (response['success'] == true) {
        // Store user data
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _message = response['message'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Login failed';
      });
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Password'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Password for ${widget.identifier}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Enter Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (_message.isNotEmpty)
              Text(_message, style: TextStyle(color: AppColors.error)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
