import 'package:flutter/material.dart';

class ConsentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consent Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please read and accept the consent form.',
              style: TextStyle(fontSize: 20),
            ),
            // Consent form content here...
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic for accepting consent
                Navigator.pop(context);
              },
              child: Text('Accept'),
            ),
          ],
        ),
      ),
    );
  }
}
