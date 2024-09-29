import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:monnaie/widgets/add_screen.dart';
import 'package:monnaie/widgets/spending_list.dart';
import 'package:monnaie/widgets/spent_card.dart';
import 'package:provider/provider.dart';
import '../../service/category_service.dart';
import '../../models/category_data.dart';
import '../../provider/category_expense_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.photoUrl,
  });
  final String title;
  final String photoUrl;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryExpenseProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final Logger logger = Logger();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;
    Future<void> handleSignOut() async {
      try {
        await googleSignIn.signOut(); // Sign out from Google
        await auth.signOut(); // Sign out from Firebase
      } catch (e) {
        logger.e('Error signing out: $e');
      }
    }

    return Scaffold(
        appBar: AppBar(
          leadingWidth: 70,
          leading: GestureDetector(
            onTap: () {
              handleSignOut();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
              ),
              child: CircleAvatar(
                radius: 5,
                backgroundImage: NetworkImage(widget.photoUrl),
              ),
            ),
          ),
          centerTitle: false,
          title: Row(
            children: [
              Transform.translate(
                offset: const Offset(
                    -6, 12), // Adjust to move title closer to leading
                child: Text(
                  "Bonjour, ${widget.title}",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFebdedc),
        ),
        body: Column(
          children: [
            const SpentCard(),
            Expanded(
              child: FutureBuilder<List<CategoryData>>(
                future: CategoryService().getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No categories found.'));
                  } else {
                    // final categories = snapshot.data!;
                    return const SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SpendingList(
                            name: 'Weekly',
                          ),
                          SpendingList(
                            name: 'Monthly',
                            maxHeight: 0,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color(0xFFc7bab8),
              ),
            ),
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFFebdedc),
            selectedIconTheme: const IconThemeData(color: Color(0xFFfdbf1e)),
            selectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.currency_bitcoin), label: "Overview"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle), label: "ADD"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile")
            ],
            onTap: (index) {
              if (index == 1) {
                showModalBottomSheet(
                  isDismissible: false,
                  backgroundColor: Colors.white,
                  elevation: 5,
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: const AddScreen(),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
