import 'package:flutter/material.dart';
import 'package:monnaie/main.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  AddScreenState createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  // final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _dateTimeController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _dateTimeController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Container(
                width: 35,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(15), child: const SpentForm())
          ],
        ),
      ),
    );
  }
}
