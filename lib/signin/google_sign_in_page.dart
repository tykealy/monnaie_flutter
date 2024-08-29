import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in_util.dart';
import 'package:flutter/material.dart';
import 'package:monnaie/widgets/styled_button.dart';

class GoogleSignInPage extends StatelessWidget {
  GoogleSignInPage({super.key});
  final handleSignIn = SignInUtil().handleSignIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          child: StyledButton(
            label: "Sign in with Google",
            action: () async {
              User? user = await handleSignIn();
              if (user != null) {
                // Successfully signed in
                // You can navigate to another page or update the state
              } else {
                // Sign-in failed
                // Show an error message or handle the failure
              }
            },
            width: 200.0,
          ),
        ),
      ),
    );
  }
}
