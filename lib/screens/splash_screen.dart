import 'package:flutter/material.dart';
import 'package:realtime_chat_app_with_ai/screens/overview_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OverviewScreen()),
            );
          },
          child: const Text('Go to Login'),
        ),
      ),
    );
  }
}
