import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:onco_50/Features/Authpages/SignInPage/signinpage.dart';
import 'package:onco_50/Features/Authpages/VerifyEmailPage/verifymailpage.dart';
import 'package:onco_50/Screens/HomeScreen/home_screen.dart';

/// AuthWrapper decides which page to show depending on the user's state.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance
          .authStateChanges(), // listens to login state
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While Firebase initializes
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If no user → go to Sign In page
        if (!snapshot.hasData) {
          return const SignInPage();
        }

        final user = snapshot.data!;

        // If signed in but email not verified → go to VerifyEmail page
        if (!user.emailVerified) {
          return const VerifyEmailPage();
        }
        // If signed in and verified → go to Home page
        return Onco50App();
      },
    );
  }
}
