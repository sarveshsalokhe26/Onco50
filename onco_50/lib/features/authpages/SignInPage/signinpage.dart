import 'package:flutter/material.dart';
import 'package:onco_50/features/authpages/signInPage/widgets/signin_title.dart';
import 'package:onco_50/features/authpages/signInPage/widgets/signin_form.dart';
import 'package:onco_50/features/authpages/signInPage/widgets/new_usersignup.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            "assets/images/fb0f2369c56c81ccd0ef108d3d0d8377.jpg",
            fit: BoxFit.cover,
          ),

          // Foreground Content
          SingleChildScrollView(
            child: Column(
              children: const [
                SizedBox(height: 130),
                SignInTitle(),
                SizedBox(height: 20),
                SignInForm(),
                SizedBox(height: 20),
                NewUserSignUp(),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
