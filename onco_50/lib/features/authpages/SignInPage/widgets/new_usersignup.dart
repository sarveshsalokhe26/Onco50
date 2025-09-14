import 'package:flutter/material.dart';

class NewUserSignUp extends StatelessWidget {
  const NewUserSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        color: const Color.fromRGBO(40, 45, 26, .200),
        borderRadius: BorderRadius.circular(30),
      ),
      child: GestureDetector(
        onTap: () {
          // Navigate to Sign In page
        },
        child: const Text(
          "Already have an account ?  SignIn",
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
