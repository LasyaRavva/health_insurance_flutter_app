import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/claim_model.dart';
import '../models/hospital_model.dart';

class ApiService {
  static const String baseUrl =
      'http://10.0.2.2:3000'; // Use 10.0.2.2 for Android emulator, localhost for iOS/web

  // Login with password
  Future<Map<String, dynamic>> login(String identifier, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier, 'password': password}),
    );
    return jsonDecode(response.body);
  }

  // Send OTP
  Future<Map<String, dynamic>> sendOtp(String identifier) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier}),
    );
    return jsonDecode(response.body);
  }

  // Verify OTP
  Future<Map<String, dynamic>> verifyOtp(String identifier, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': identifier, 'otp': otp}),
    );
    return jsonDecode(response.body);
  }

  // Get user details
  Future<User> getUser(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    return User.fromJson(jsonDecode(response.body));
  }

  // Get user's claims
  Future<List<Claim>> getClaims(String userId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/claims?userId=$userId'),
    );
    List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => Claim.fromJson(e)).toList();
  }

  // Submit claim with image
  Future<Map<String, dynamic>> submitClaim(
    String userId,
    String description,
    String imagePath,
  ) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/claims'));
    request.fields['userId'] = userId;
    request.fields['description'] = description;
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    final response = await request.send();
    return jsonDecode(await response.stream.bytesToString());
  }

  // Get nearby hospitals
  Future<List<Hospital>> getNearbyHospitals(double lat, double lng) async {
    final response = await http.get(
      Uri.parse('$baseUrl/hospitals?lat=$lat&lng=$lng'),
    );
    List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => Hospital.fromJson(e)).toList();
  }

  // Get coverage info (placeholder)
  Future<Map<String, dynamic>> getCoverage(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/coverage/$userId'));
    return jsonDecode(response.body);
  }
}
