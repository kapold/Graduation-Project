import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int statusIndex = 0;
  List<String> switchStates = [
    'Active', 'Deliveried'
  ];
  List<String> activeOrders = [];
  List<String> deliveredOrders = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: Column(
                children: [
                  const SizedBox(height: 10),
                  ToggleSwitch(
                      activeBgColor: const [
                        Colors.deepOrange
                      ],
                      minWidth: 140,
                      cornerRadius: 20,
                      initialLabelIndex: statusIndex,
                      totalSwitches: 2,
                      labels: switchStates,
                      animate: true,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      onToggle: (index) {
                        setState(() {
                          statusIndex = index as int;
                        });
                        String state = switchStates[index as int];
                      }
                  ),
                  const SizedBox(height: 10),
                  statusIndex == 0 ?
                      const Expanded(
                        child: Center(
                          child: Text('No active deliveries')
                        )
                      ) :
                      const Expanded(
                          child: Center(
                              child: Text('No deliveried deliveries')
                          )
                      )
                ]
            )
          )
        )
    );
  }
}
