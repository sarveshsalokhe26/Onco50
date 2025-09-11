import 'package:flutter/material.dart';
import 'features/authpages/SignUpPage/signup_page.dart';

// The main entry point for the Flutter application.
void main() {
  runApp(const MyApp());
}

// The root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Drug Concentration App',
      theme: ThemeData(
        // Swiggy-like primary color
        primarySwatch: Colors.brown,
        // Using a clear and modern font.
        fontFamily: 'Inter',
        // Setting a clean white background.
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0), // Less rounding
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          filled: true,
          fillColor: Colors.grey[50], // Very light grey fill
          hintStyle: TextStyle(color: Colors.grey[500]),
          // Slightly reduced padding for a cleaner look
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
        ),
      ),
      home: const SignUpPage(),
    );
  }
}
