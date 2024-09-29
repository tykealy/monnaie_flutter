import 'package:flutter/material.dart';

class SpendingHeader extends StatefulWidget {
  final String name;
  final num dayLeft = 6;
  final double budgeted = 100.0;
  final double total = 100.0;
  const SpendingHeader({
    super.key,
    required this.name,
  });

  @override
  State<SpendingHeader> createState() => _SpendingHeaderState();
}

class _SpendingHeaderState extends State<SpendingHeader> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double parentWidth = constraints.maxWidth;
        double nameWidth = parentWidth * 0.4; // 50% of parent's width
        double budgetedWidth = parentWidth * 0.3; // 30% of parent's width
        double totalWidth = parentWidth * 0.3; // 20% of parent's width

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: nameWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                      Text(
                        "Day Left: ${widget.dayLeft}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: budgetedWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Budgeted",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                      Text(
                        "${widget.budgeted}\$",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: totalWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Left",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                      Text(
                        "${widget.budgeted - widget.total}\$",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
