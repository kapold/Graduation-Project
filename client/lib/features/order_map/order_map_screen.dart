import 'dart:async';

import 'package:client/repositories/user_repository.dart';
import 'package:client/utils/logs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../widgets/app_bar_style.dart';

class OrderMapScreen extends StatefulWidget {
  final int deliverymanId;

  const OrderMapScreen({super.key, required this.deliverymanId});

  @override
  State<OrderMapScreen> createState() => _OrderMapScreenState();
}

class _OrderMapScreenState extends State<OrderMapScreen> {
  late final MapController _mapController;
  LatLng _center = const LatLng(0, 0);
  Timer? _timer;

  @override
  void initState() {
    _mapController = MapController();
    _fetchLocation();
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _fetchLocation();
    });
  }

  void _fetchLocation() async {
    try {
      var userGeo = await UserRepository.getUserGeoById(widget.deliverymanId);
      if (mounted) {
        setState(() {
          _center = LatLng(userGeo['latitude'], userGeo['longitude']);
          _mapController.move(_center, _mapController.zoom);
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          Logs.traceLog('Ошибка при получении данных: $e');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.getCommonAppBar('Карта с доставщиком', context),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _center,
          zoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _center,
                child: Image.asset('assets/icons/map_point.png'),
                width: 50,
                height: 50,
                alignment: Alignment.center,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mapController.move(_center, 16),
        tooltip: 'Приблизить к точке',
        child: const Icon(Icons.zoom_in),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _mapController.dispose();
    super.dispose();
  }
}
