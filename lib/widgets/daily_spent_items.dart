import 'package:flutter/material.dart';
import 'package:monnaie/widgets/history_list.dart';

class DailySpentItems extends StatefulWidget {
  final String date;
  final List<Map<String, String>> items;

  const DailySpentItems({super.key, required this.items, required this.date});
  @override
  DailySpentItemsState createState() => DailySpentItemsState();
}
