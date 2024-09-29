import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monnaie/signin/google_sign_in_page.dart';
import 'package:monnaie/view/home/my_home_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:monnaie/provider/category_expense_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryExpenseProvider()),
      ],
      child: MaterialApp(
          title: 'Monnaie',
          debugShowCheckedModeBanner: false, // Add this line
          theme: ThemeData(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: const Color(
                      0xFFfdbf1e), // Change the color of the date picker here
                  onPrimary: const Color(0xFF000000),
                  // onSurface: const Color(0xFFebdedc)
                ),
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
          home: const AuthChecker()),
    );
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
