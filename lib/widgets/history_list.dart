import 'package:flutter/material.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({Key? key}) : super(key: key);

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
              height: 450,
              decoration: BoxDecoration(
                color: const Color(0xFFf3ebea),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFFc7bab8),
                ),
              ),
              child: ListView(children: [
                DailySpentItem(
                  items: items,
                  date: "04 June",
                ),
                DailySpentItem(
                  items: items,
                  date: "04 July",
                )
              ])),
        ],
      ),
    );
  }
}

class DailySpentItem extends StatefulWidget {
  final String date;
  final List<Map<String, String>> items;

  const DailySpentItem({super.key, required this.items, required this.date});
  @override
  DailySpentItemState createState() => DailySpentItemState();
}

class DailySpentItemState extends State<DailySpentItem> {
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
    Key? key,
    required this.title,
    required this.time,
    required this.amount,
    required this.category,
  }) : super(key: key);

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
