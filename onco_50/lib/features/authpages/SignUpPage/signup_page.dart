import 'package:flutter/material.dart';
import 'widgets/signup_title.dart';
import 'widgets/signup_form.dart';
import 'widgets/already_have_account.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, //Keeps keyboard open
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
                SignUpTitle(),
                SizedBox(height: 20),
                SignUpForm(),
                SizedBox(height: 20),
                AlreadyHaveAccount(),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
