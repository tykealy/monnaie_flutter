import 'package:flutter/material.dart';
import 'package:monnaie/widgets/spending_header.dart';

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
  final List<Map<String, String>> items = List.generate(
      5,
      (index) => {
            'title': 'Buying Bitcoin',
            'time': 'on 2021-10-10',
            'amount': '0.0001 BTC',
            'category': 'crypto',
          });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
          const SpendingItem(
              icon: '☕️', name: 'Koffee', bdugeted: 100, left: 20),
          const SpendingItem(icon: '🍺', name: 'Pherk', bdugeted: 20, left: 18),
          const SpendingItem(
              icon: '🪙', name: 'Crypto', bdugeted: 55, left: 55),
        ],
      ),
    );
  }
}

class SpendingItem extends StatefulWidget {
  final String icon;
  final String name;
  final double bdugeted;
  final double left;

  const SpendingItem({
    super.key,
    required this.icon,
    required this.name,
    required this.bdugeted,
    required this.left,
  });

  @override
  State<SpendingItem> createState() => _SpendingItemState();
}

class _SpendingItemState extends State<SpendingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double parentWidth = constraints.maxWidth;
          double iconNameWidth = parentWidth * 0.4; // 40% of parent's width
          double budgetedWidth = parentWidth * 0.3; // 30% of parent's width
          double leftWidth = parentWidth * 0.3; // 30% of parent's width

          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: iconNameWidth,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFebdedc),
                        shape: BoxShape.circle,
                      ),
                      child: Text(widget.icon,
                          style: const TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      widget.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: budgetedWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.bdugeted}\$',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: leftWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.left}\$',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
