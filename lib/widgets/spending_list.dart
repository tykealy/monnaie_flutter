import 'package:flutter/material.dart';
import 'package:monnaie/widgets/spending_header.dart';
import 'package:monnaie/widgets/spending_item.dart';

class SpendingList extends StatefulWidget {
  final String name;
  const SpendingList({
    super.key,
    required this.name,
  });

  @override
  SpendingListState createState() => SpendingListState();
}

class SpendingListState extends State<SpendingList> {
  final List<SpendingData> spendingItems = [
    SpendingData(icon: '☕️', name: 'Koffee', budgeted: 100, left: 20),
    SpendingData(icon: '🍺', name: 'Pherk', budgeted: 20, left: 18),
    SpendingData(icon: '🪙', name: 'Crypto', budgeted: 55, left: 55),
    SpendingData(icon: '🍔', name: 'Burger', budgeted: 50, left: 30),
    // SpendingData(icon: '🛒', name: 'Groceries', budgeted: 200, left: 150),
  ];

  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFebdedc),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFc7bab8),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10, top: 5, bottom: 5, right: 10),
                  child: Column(
                    children: [
                      SpendingHeader(
                        name: widget.name,
                      ),
                    ],
                  ),
                )),
          ),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 150), // Faster animation
            firstChild: Container(),
            secondChild: Container(
              constraints: const BoxConstraints(
                maxHeight: 250,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: spendingItems.map((item) {
                    return SpendingItem(
                      icon: item.icon,
                      name: item.name,
                      bdugeted: item.budgeted,
                      left: item.left,
                    );
                  }).toList(),
                ),
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
          ),
        ],
      ),
    );
  }
}

class SpendingData {
  final String icon;
  final String name;
  final double budgeted;
  final double left;

  SpendingData({
    required this.icon,
    required this.name,
    required this.budgeted,
    required this.left,
  });
}
