import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final _auth = FirebaseAuth.instance;
  Timer? _timer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Start periodic check every 3 seconds
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _checkVerified(),
    );
  }

  Future<void> _checkVerified() async {
    User? user = _auth.currentUser;
    await user?.reload(); // refresh the user
    user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      _timer?.cancel(); // stop checking
      if (!mounted) return;

      // Navigate to HomePage
      Navigator.of(context).pushReplacementNamed("/home");
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // stop when page is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify your email")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "We’ve sent a verification link to your email.\n"
                "Please verify your email to continue.\n\n"
                "This page will automatically refresh once verified.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: _isLoading ? null : _resendVerification,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Resend verification email"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
