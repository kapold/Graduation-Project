import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graduation_ap/repositories/user_repository.dart';
import 'package:graduation_ap/utils/app_data.dart';
import 'package:graduation_ap/utils/logs.dart';

import '../../styles/app_colors.dart';
import '../../styles/ts.dart';
import '../auth/auth_screen.dart';

class DeliveryPanelScreen extends StatefulWidget {
  const DeliveryPanelScreen({super.key});

  @override
  State<DeliveryPanelScreen> createState() => _DeliveryPanelScreenState();
}

class _DeliveryPanelScreenState extends State<DeliveryPanelScreen> {
  String _location = 'Unknown';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startLocationUpdates();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLocationUpdates() {
    _checkAndRequestPermission().then((_) {
      _fetchLocation();

      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        _fetchLocation();
      });
    }).catchError((error) {
      Logs.traceLog('Error starting location updates: $error');
    });
  }

  Future<void> _checkAndRequestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));
      throw Exception('Location permissions are permanently denied');
    }
  }

  void _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      UserRepository.updateUserGeo(position.latitude, position.longitude);
      setState(() {
        _location = 'Lat: ${position.latitude}, Lon: ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _location = 'Failed to get location: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Доставщик', style: TS.getOpenSans(20, FontWeight.w500, AppColors.black)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app_outlined, color: AppColors.darkerRed),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                    (Route<dynamic> route) => false,
              );
            },
            tooltip: 'Выйти',
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppData.currentUser.toJson().toString()),
              const SizedBox(height: 40),
              Text('Current Location: $_location'),
            ],
          ),
        ),
      ),
    );
  }
}
