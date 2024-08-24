import 'package:flutter/material.dart';
import 'package:monnaie/widgets/daily_spent_items.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key});

  @override
  HistoryListState createState() => HistoryListState();
}

class HistoryListState extends State<HistoryList> {
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
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("History"),
          Container(
              margin: const EdgeInsets.only(top: 10),
              height: 400,
              decoration: BoxDecoration(
                color: const Color(0xFFf3ebea),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFc7bab8),
                ),
              ),
              child: ListView(children: [
                DailySpentItems(
                  items: items,
                  date: "04 June",
                ),
                DailySpentItems(
                  items: items,
                  date: "04 July",
                )
              ])),
        ],
      ),
    );
  }
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
                    color: Color(0xFFf3ebea),
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
