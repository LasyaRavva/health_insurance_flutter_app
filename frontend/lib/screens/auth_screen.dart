import 'package:flutter/material.dart';
import '../styles/colors.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _identifier = '';
  String _method = 'otp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Health Insurance',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 40),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number / Email / Policy Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your identifier' : null,
                onSaved: (value) => _identifier = value!,
              ),
              SizedBox(height: 20),
              Text('Choose login method:'),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('OTP'),
                      leading: Radio<String>(
                        value: 'otp',
                        groupValue: _method,
                        onChanged: (value) => setState(() => _method = value!),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Password'),
                      leading: Radio<String>(
                        value: 'password',
                        groupValue: _method,
                        onChanged: (value) => setState(() => _method = value!),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_method == 'otp') {
                      Navigator.pushNamed(
                        context,
                        '/otp',
                        arguments: _identifier,
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        '/password',
                        arguments: _identifier,
                      );
                    }
                  }
                },
                child: Text('Proceed'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
