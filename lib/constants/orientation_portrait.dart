import 'package:flutter/material.dart';

class OrientationPortrait extends StatelessWidget {
  const OrientationPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please Rotate'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please rotate your device to landscape mode.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Got it!'),
            ),
          ],
        ),
      ),
    );
  }
}
