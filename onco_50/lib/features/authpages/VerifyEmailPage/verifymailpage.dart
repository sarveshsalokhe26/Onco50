import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _checkVerified() async {
    User? user = _auth.currentUser;
    await user?.reload(); // refresh user
    user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email not verified yet.")),
      );
    }
  }

  Future<void> _resendVerification() async {
    try {
      setState(() => _isLoading = true);
      await _auth.currentUser?.sendEmailVerification();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Verification email resent.")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify your email")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "We’ve sent a verification link to your email.\nPlease verify to continue.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkVerified,
              child: const Text("I have verified"),
            ),
            TextButton(
              onPressed: _isLoading ? null : _resendVerification,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Resend verification email"),
            ),
          ],
        ),
      ),
    );
  }
}
