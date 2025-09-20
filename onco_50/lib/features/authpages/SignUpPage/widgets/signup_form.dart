import 'package:flutter/material.dart';

//Dependencies
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import path
import 'custom_text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  // controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Loading state to disable multiple taps and show progress
  bool _isLoading = false;

  // Firebase instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    // form validation (will also run field validators)
    if (!_formKey.currentState!.validate())
      return; //Validate the text fields and returns back if there are errors in the text field

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() => _isLoading = true);

    try {
      // 1) Create user with Firebase Auth
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = cred.user;
      if (user == null)
        throw FirebaseAuthException(
          code: 'no-user',
          message: 'User not created',
        );

      // 2) Creating a user profile in Firestore (separate from Auth)
      final userDoc = _firestore.collection('users').doc(user.uid);

      await userDoc.set({
        'uid': user.uid,
        'email': user.email,
        'createdAt': FieldValue.serverTimestamp(),
        'displayName': user.displayName ?? '',
        'photoUrl': user.photoURL ?? '',
        // add other fields you need, but avoid storing sensitive info like passwords
      });

      // 3) Send email verification
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      // 4) Show a confirmation UI and guide the user to verify email
      if (!mounted) return;
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Verify your email'),
          content: Text(
            'A verification link has been sent to $email.\n'
            'Please check your inbox and verify your email before signing in.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // close dialog
                // Option: navigate to sign-in page:
                // Navigator.of(context).pushReplacementNamed('/signin');
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () async {
                // Resend verification (rate-limit on server side recommended)
                try {
                  await user.sendEmailVerification();
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Verification email resent')),
                  );
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not resend: $e')),
                  );
                }
              },
              child: const Text('Resend'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      final message = _mapFirebaseAuthErrorToMessage(e);
      if (mounted) _showSnackBar(message);
    } catch (e) {
      if (mounted) _showSnackBar('An unexpected error occurred. Try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _mapFirebaseAuthErrorToMessage(FirebaseAuthException e) {
    // Maping common FirebaseAuthException codes to user-friendly messages
    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'email-already-in-use':
        return 'This email is already registered. Try signing in.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak. Use at least 6 characters.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      case 'no-user':
        return 'Could not create user. Please try again.';
      default:
        return e.message ?? 'Authentication error. Please try again.';
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // Optional: add more robust password strength validator
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    // add regex checks for digits/symbols/upper-case if required
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromRGBO(66, 74, 43, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Email
            CustomTextField(
              controller: _emailController,
              hintText: "Email",
              imagePath: "assets/icons/MailIcon/mail.png",
              obscureText: false,
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Please enter your email";
                if (!RegExp(
                  r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
                ).hasMatch(value)) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Password
            CustomTextField(
              controller: _passwordController,
              hintText: "Password",
              imagePath: "assets/icons/MailIcon/padlock.png",
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: const Color.fromRGBO(40, 45, 26, 1),
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
              validator: _passwordValidator,
            ),

            const SizedBox(height: 16),

            // Confirm Password
            CustomTextField(
              controller: _confirmPasswordController,
              hintText: "Confirm Password",
              imagePath: "assets/icons/MailIcon/padlock.png",
              obscureText: _obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: const Color.fromRGBO(40, 45, 26, 1),
                ),
                onPressed: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return "Please confirm your password";
                if (value != _passwordController.text)
                  return "Passwords do not match";
                return null;
              },
            ),

            const SizedBox(height: 24),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(40, 45, 26, .75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.6),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Sign up",
                        style: TextStyle(
                          letterSpacing: 0.50,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
