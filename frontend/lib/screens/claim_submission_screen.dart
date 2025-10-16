import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';
import '../styles/colors.dart';
import '../widgets/loading_screen.dart';

class ClaimSubmissionScreen extends StatefulWidget {
  @override
  _ClaimSubmissionScreenState createState() => _ClaimSubmissionScreenState();
}

class _ClaimSubmissionScreenState extends State<ClaimSubmissionScreen> {
  final _descriptionController = TextEditingController();
  final ApiService _apiService = ApiService();
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _imagePath = pickedFile.path);
    }
  }

  Future<void> _submitClaim() async {
    if (_descriptionController.text.isEmpty || _imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _apiService.submitClaim(
        'user123',
        _descriptionController.text,
        _imagePath!,
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Claim submitted successfully')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to submit claim')));
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
        title: Text('Submit Claim'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Claim Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.camera_alt),
              label: Text('Select Image'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            SizedBox(height: 20),
            if (_imagePath != null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.file(File(_imagePath!), fit: BoxFit.cover),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitClaim,
              child: Text('Submit Claim'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
