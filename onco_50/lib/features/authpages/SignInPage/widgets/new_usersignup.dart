import 'package:flutter/material.dart';
import 'package:onco_50/features/authpages/SignUpPage/signup_page.dart';

class NewUserSignUp extends StatelessWidget {
  const NewUserSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),
        color: const Color.fromRGBO(40, 45, 26, .200),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Not registered yet ?",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 4),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
            child: const Text(
              "Signup",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
