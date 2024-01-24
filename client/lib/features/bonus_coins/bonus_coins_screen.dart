import 'package:flutter/material.dart';

class BonusCoinsScreen extends StatefulWidget {
  const BonusCoinsScreen({super.key});

  @override
  State<BonusCoinsScreen> createState() => _BonusCoinsScreenState();
}

class _BonusCoinsScreenState extends State<BonusCoinsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No bonuses'),
      ),
    );
  }
}
