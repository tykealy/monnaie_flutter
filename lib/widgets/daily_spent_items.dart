import 'package:flutter/material.dart';
import 'package:monnaie/widgets/spent_item.dart';

class DailySpentItems extends StatefulWidget {
  final String date;
  final List<Map<String, String>> items;

  const DailySpentItems({super.key, required this.items, required this.date});
  @override
  DailySpentItemsState createState() => DailySpentItemsState();
}

class DailySpentItemsState extends State<DailySpentItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.date),
        Column(
          children: widget.items.map((item) {
            return SpentItem(
              title: item['title']!,
              time: item['time']!,
              amount: item['amount']!,
              category: item['category']!,
            );
          }).toList(),
        ),
      ]),
    );
  }
}
