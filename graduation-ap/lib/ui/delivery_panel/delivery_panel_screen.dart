import 'package:flutter/material.dart';

class DeliveryPanelScreen extends StatefulWidget {
  const DeliveryPanelScreen({super.key});

  @override
  State<DeliveryPanelScreen> createState() => _DeliveryPanelScreenState();
}

class _DeliveryPanelScreenState extends State<DeliveryPanelScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Deliveryman'),
      ),
    );
  }
}
