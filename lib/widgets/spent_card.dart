import 'package:flutter/material.dart';

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
                              child: const SpentCardButton(action: "Swap"),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              child: const SpentCardButton(action: "Transfer"),
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

class SpentCardButton extends StatefulWidget {
  final String action;

  const SpentCardButton({Key? key, required this.action}) : super(key: key);

  @override
  SpentCardButtonState createState() => SpentCardButtonState();
}

class SpentCardButtonState extends State<SpentCardButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130, // Set the width you want here
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFfdbf1e),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(3, 4), // Position of shadow
              blurRadius: 0, // Blur level
              spreadRadius: 1, // Spread level
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Handle button press
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                const Color(0xFFfdbf1e),
              ), // Make the button background transparent
              elevation: MaterialStateProperty.all(0)),
          child: Text(
            widget.action,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
