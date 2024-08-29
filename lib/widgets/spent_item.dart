import 'package:flutter/material.dart';

class SpentItem extends StatelessWidget {
  final String title;
  final String time;
  final String amount;
  final String category;

  const SpentItem({
    super.key,
    required this.title,
    required this.time,
    required this.amount,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          const Icon(Icons.currency_bitcoin),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(time),
          ]),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFebdedc),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.currency_franc_outlined,
                        size: 15,
                        color: Colors.red,
                      ),
                      Text(amount, style: const TextStyle(color: Colors.red)),
                    ],
                  )),
              Text(category),
            ],
          ),
        ],
      ),
    );
  }
}
