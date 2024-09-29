import 'package:flutter/material.dart';
import 'package:monnaie/models/category_data.dart';
import 'package:monnaie/provider/category_expense_provider.dart';
import 'package:monnaie/widgets/spending_header.dart';
import 'package:monnaie/widgets/spending_item.dart';
import 'package:provider/provider.dart';

class SpendingList extends StatefulWidget {
  final String name;
  final double maxHeight;
  const SpendingList({
    super.key,
    this.maxHeight = 250,
    required this.name,
  });

  @override
  SpendingListState createState() => SpendingListState();
}

class SpendingListState extends State<SpendingList> {
  late List<CategoryData> spendingItems = [];
  int getWeekOfYear(DateTime date) {
    DateTime firstDayOfYear = DateTime(date.year, 1, 1);
    int dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    return (dayOfYear / 7).ceil();
  }

  int getMonth(DateTime dateTime) {
    return dateTime.month;
  }

  int getYear(DateTime dateTime) {
    return dateTime.year;
  }

  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    // if (widget.name == 'Weekly') {
    //   CategoryService()
    //       .getCategoriesWithExpenses(year, week: week)
    //       .then((value) {
    //     setState(() {
    //       spendingItems = value;
    //     });
    //   });
    // } else {
    //   CategoryService()
    //       .getCategoriesWithExpenses(year, month: month)
    //       .then((value) {
    //     setState(() {
    //       spendingItems = value;
    //     });
    //   });
    // }
  }

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
            duration: const Duration(milliseconds: 150),
            firstChild: Container(),
            secondChild: Container(
              constraints: widget.maxHeight > 0
                  ? BoxConstraints(maxHeight: widget.maxHeight)
                  : null,
              child: SingleChildScrollView(
                child: Consumer<CategoryExpenseProvider>(
                    builder: (context, value, child) {
                  spendingItems = widget.name == 'Weekly'
                      ? value.weeklyCategoryExpenses.cast<CategoryData>()
                      : value.monthlyCategoryExpenses.cast<CategoryData>();
                  return Column(
                    children: spendingItems.map((item) {
                      double expense = 0;
                      try {
                        expense = item.expense;
                      } catch (e) {
                        expense = 0;
                      }
                      return SpendingItem(
                        icon: item.icon,
                        name: item.name,
                        budgeted: item.budget,
                        left: item.budget - expense,
                      );
                    }).toList(),
                  );
                }),
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
