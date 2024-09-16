import 'package:flutter/material.dart';

class StyledButton extends StatefulWidget {
  final Function action;
  final double width;
  final String? label;
  final Icon? icon;
  final double? height;
  const StyledButton(
      {super.key,
      required this.action,
      this.height,
      this.label,
      this.width = 130.0,
      this.icon});

  @override
  StyledButtonState createState() => StyledButtonState();
}

class StyledButtonState extends State<StyledButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
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
              padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
              backgroundColor: WidgetStateProperty.all(
                const Color(0xFFfdbf1e),
              ), // Make the button background transparent
              elevation: WidgetStateProperty.all(0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) widget.icon!,
              if (widget.icon != null && widget.label != null)
                const SizedBox(width: 5),
              if (widget.label != null)
                Text(
                  widget.label!,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
