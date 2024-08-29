import 'package:flutter/material.dart';

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
