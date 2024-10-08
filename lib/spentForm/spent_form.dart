import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:monnaie/models/category_data.dart';
import 'package:monnaie/provider/category_expense_provider.dart';
import 'package:monnaie/service/expense_record_service.dart';
import 'package:monnaie/widgets/styled_button.dart';
import 'package:provider/provider.dart';
import '../models/expense_data.dart';

class SpentForm extends StatefulWidget {
  const SpentForm({super.key});
  @override
  SpentFormState createState() => SpentFormState();
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

class SpentFormState extends State<SpentForm> {
  final _dateC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final description = TextEditingController();
  final amount = TextEditingController();
  // final CategoryService _categoryService = CategoryService();
  String? _selectedCategory;

  List<CategoryData> _categories = [];
  bool _isLoading = true;

  Future<void> _fetchCategories() async {
    try {
      List<CategoryData> categories =
          Provider.of<CategoryExpenseProvider>(context, listen: false)
              .categories;
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  submitHandler(GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      double enteredAmount = double.parse(amount.text);
      String selectedDate = _dateC.text;
      String enteredDescription = description.text;
      String selectedCategory = _selectedCategory ?? 'No category selected';

      final expense = ExpenseData(
          amount: enteredAmount,
          date: selectedDate,
          description: enteredDescription,
          type: selectedCategory);

      final result = await ExpenseRecordService().saveExpense(expense);
      if (!context.mounted) return;
      if (result) {
        Provider.of<CategoryExpenseProvider>(context, listen: false)
            .addExpense();
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save expense'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    amount.text = '0';
    _dateC.text = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
  }

  Future displayDatePicker(
    BuildContext context,
  ) async {
    DateTime selectedDate = DateTime.now();
    DateTime initial = DateTime(2000);
    DateTime last = DateTime(2025);
    var date = await showDatePicker(
        context: context,
        firstDate: initial,
        lastDate: last,
        initialDate: selectedDate);
    if (date != null) {
      displayTimePicker(date);
    }
  }

  Future displayTimePicker(var dateTime) async {
    TimeOfDay initialTime = TimeOfDay.now();
    var time = await showTimePicker(context: context, initialTime: initialTime);

    if (time != null && dateTime != null) {
      setState(() {
        _dateC.text =
            "${DateFormat('yyyy-MM-dd').format(dateTime)} ${DateFormat('HH:mm').format(DateTime(dateTime.year, dateTime.month, dateTime.day, time.hour, time.minute))}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Amount:",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        TextFormField(
                          controller: amount,
                          onTapOutside: (event) => FocusScope.of(context)
                              .unfocus(), // Unfocus the text field
                          cursorColor: Colors.black,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 20, right: 20, top: 15, bottom: 15),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black, // Border color
                                width: 2.0, // Border thickness
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black, // Border color
                                width: 2.0, // Border thickness
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ]),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date and Time:',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.none,
                        readOnly: true,
                        cursorColor: Colors.black,
                        controller: _dateC,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 15),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, // Border color
                              width: 2.0, // Border thickness
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black, // Border color
                              width: 2.0, // Border thickness
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                        onTap: () => (displayDatePicker(context)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Categories:"),
                _isLoading
                    ? const CircularProgressIndicator() // Show loading indicator while fetching categories
                    : DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(15),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                        value: _categories.isNotEmpty
                            ? _selectedCategory
                            : null, // Ensure the value is valid
                        items: _categories.map((CategoryData category) {
                          return DropdownMenuItem<String>(
                            value: category.id,
                            child: Text("${category.icon} ${category.name}"),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                        validator: (value) =>
                            value == null ? 'Please select a category' : null,
                      ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reason:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                TextFormField(
                  controller: description,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 15),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Border color
                        width: 2.0, // Border thickness
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Border color
                        width: 2.0, // Border thickness
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: StyledButton(
                  action: () => submitHandler(_formKey, context),
                  label: "Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
