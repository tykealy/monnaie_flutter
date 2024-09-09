import 'package:flutter/material.dart';
import 'package:monnaie/widgets/styled_button.dart';

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
  final List<SpendingData> spendingItems = [
    SpendingData(icon: '☕️', name: 'Koffee', budgeted: 100, left: 20),
    SpendingData(icon: '🍺', name: 'Pherk', budgeted: 20, left: 18),
    SpendingData(icon: '🪙', name: 'Crypto', budgeted: 55, left: 55),
    SpendingData(icon: '🍔', name: 'Burger', budgeted: 50, left: 30),
    SpendingData(icon: '🛒', name: 'Groceries', budgeted: 200, left: 150),
  ];
  final _dateC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedOption;

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
            "${dateTime.toLocal().toString().split(" ")[0]} ${time.format(context)}";
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
                          onTapOutside: (event) => FocusScope.of(context)
                              .unfocus(), // Unfocus the text field
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
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
                DropdownButtonFormField<String>(
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
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Border color
                        width: 2.0, // Border thickness
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  value: _selectedOption,
                  items: spendingItems.map((SpendingData option) {
                    return DropdownMenuItem<String>(
                      value: option.name,
                      child: Text("${option.icon} ${option.name}"),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    _selectedOption = newValue;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
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

submitHandler(GlobalKey<FormState> formkey, context) {
  if (formkey.currentState != null && formkey.currentState!.validate()) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Processing Datazzz')));
  }
}
