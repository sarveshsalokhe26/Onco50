import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon; // for Material icons
  final String? imagePath; // for PNG icons
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.imagePath,
    required this.obscureText,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: imagePath != null
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(imagePath!, height: 22, width: 22),
              )
            : Icon(icon, color: const Color.fromRGBO(40, 45, 26, 1)),
        suffixIcon: suffixIcon,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color.fromRGBO(40, 45, 26, 1),
            width: 2,
          ),
        ),
      ),
    );
  }
}
