import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:monnaie/widgets/add_screen.dart';
import 'package:monnaie/widgets/spending_list.dart';
import 'package:monnaie/widgets/spent_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title, required this.photoUrl});
  final String title;
  final String photoUrl;

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
                backgroundImage: NetworkImage(photoUrl),
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
                  "Bonjour, $title",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFebdedc),
        ),
        body: const SingleChildScrollView(
            child: Column(
          children: [
            SpentCard(),
            SpendingList(
              name: 'Weekly',
            ),
            SpendingList(
              name: 'Monthly',
              maxHeight: 0,
            ),
          ],
        )),
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
                  elevation: 5,
                  showDragHandle: false,
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
