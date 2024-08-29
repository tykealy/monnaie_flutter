import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monnaie/signin/google_sign_in_page.dart';
import 'package:monnaie/view/home/my_home_page.dart';
import 'widgets/styled_button.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Monnaie',
        debugShowCheckedModeBanner: false, // Add this line
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
              primary: const Color(
                  0xFFfdbf1e), // Change the color of the date picker here
              onPrimary: const Color(0xFF000000),
              onBackground: const Color(0xFFebdedc)),
          scaffoldBackgroundColor: const Color(0xFFf3ebea),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFfdbf1e), width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        home: const AuthChecker());
  }
}

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});
  @override
  AuthCheckerState createState() => AuthCheckerState();
}

class AuthCheckerState extends State<AuthChecker> {
  User? _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return GoogleSignInPage();
    } else {
      return MyHomePage(
        photoUrl: _user?.photoURL ?? "",
        title: _user?.displayName ?? "",
      );
    }
  }
}

class SpentForm extends StatefulWidget {
  const SpentForm({super.key});
  @override
  SpentFormState createState() => SpentFormState();
}

class SpentFormState extends State<SpentForm> {
  final _dateC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  child: TextFormField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Amount',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    keyboardType: TextInputType.none,
                    readOnly: true,
                    cursorColor: Colors.black,
                    controller: _dateC,
                    decoration: const InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    onTap: () => (displayDatePicker(context)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: 'Reason',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
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
