import 'package:flutter/material.dart';
// import 'login_screen.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset("assets/images/icons/shape-icon.png"),
        ),

        // child: ElevatedButton(
        //   onPressed: () {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => const LoginScreen()),
        //     );
        //   },
        //   child: const Text('Mendaftar dengan Email'),
        // ),
      ),
    );
  }
}
