import 'package:flutter/material.dart';

class SpentCardButton extends StatefulWidget {
  final String label;
  final Function action;
  final double width;

  const SpentCardButton(
      {super.key,
      required this.action,
      required this.label,
      this.width = 130.0});

  @override
  SpentCardButtonState createState() => SpentCardButtonState();
}

class SpentCardButtonState extends State<SpentCardButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
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
            widget.action();
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
            widget.label,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
