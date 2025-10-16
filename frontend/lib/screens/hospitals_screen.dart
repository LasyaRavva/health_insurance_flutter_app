import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/hospital_model.dart';
import '../services/api_service.dart';
import '../styles/colors.dart';
import '../widgets/loading_screen.dart';

class HospitalsScreen extends StatefulWidget {
  @override
  _HospitalsScreenState createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  final ApiService _apiService = ApiService();
  List<Hospital> _hospitals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getNearbyHospitals();
  }

  Future<void> _getNearbyHospitals() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        final hospitals = await _apiService.getNearbyHospitals(
          position.latitude,
          position.longitude,
        );
        setState(() {
          _hospitals = hospitals;
          _isLoading = false;
        });
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Location permission denied')));
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to get location')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: _hospitals.isEmpty
          ? Center(child: Text('No hospitals found nearby'))
          : ListView.builder(
              itemCount: _hospitals.length,
              itemBuilder: (context, index) {
                final hospital = _hospitals[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.local_hospital,
                      color: AppColors.primaryGreen,
                    ),
                    title: Text(hospital.name),
                    subtitle: Text(hospital.address),
                    trailing: Icon(Icons.phone),
                    onTap: () {
                      // Could launch phone dialer
                    },
                  ),
                );
              },
            ),
    );
  }
}
