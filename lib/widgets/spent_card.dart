import 'package:flutter/material.dart';
import 'package:monnaie/widgets/styled_button.dart';

class SpentCard extends StatelessWidget {
  const SpentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFf3ebea),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFc7bab8),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 15, right: 15, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total Spent"),
                        const Text(
                          "7777\$",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child:
                                  SpentCardButton(label: "Swap", action: () {}),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: SpentCardButton(
                                  label: "Category", action: () {}),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
