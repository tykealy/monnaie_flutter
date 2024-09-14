import 'package:flutter/material.dart';
import 'package:monnaie/spentForm/spent_form.dart';

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
      child: Column(
        children: <Widget>[
          const Text(
            'Add Expense',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('Enter your details here',
              style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          Container(padding: const EdgeInsets.all(15), child: const SpentForm())
        ],
      ),
    );
  }
}
