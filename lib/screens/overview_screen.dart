import 'package:flutter/material.dart';
import 'package:realtime_chat_app_with_ai/screens/login_screen.dart';
import 'package:realtime_chat_app_with_ai/screens/register_screen.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/amboai-white.png",
              width: 150,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Chat Bahaso Minang",
                style: TextStyle(
                    fontSize: 80, color: Colors.white, fontFamily: 'Caros'),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 50),
              child: Text(
                "Aplikasi obrolan kami adalah cara sempurna untuk berbicara dengan kecerdasan buatan dengan bahasa minang",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: "Circular-Book"),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset("assets/images/icons/facebook-icon.png"),
                  onPressed: () {
                    // Handle Facebook login
                  },
                ),
                IconButton(
                  icon: Image.asset("assets/images/icons/google-icon.png"),
                  onPressed: () {
                    // Handle Google login
                  },
                ),
                IconButton(
                  icon: Image.asset("assets/images/icons/apple-icon.png"),
                  onPressed: () {
                    // Handle Apple login
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: const Divider(
                        color: Colors.white,
                        height: 36,
                      )),
                ),
                const Text(
                  "Atau",
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.white,
                        height: 36,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 15, bottom: 15),
                backgroundColor:
                    Colors.white, // Ubah background color sesuai kebutuhan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Border radius diatur menjadi 10
                ),
              ),
              child: const Text(
                'Mendaftar dengan Email',
                style:
                    TextStyle(color: Colors.black, fontFamily: 'Caros-Medium'),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: RichText(
                  text: const TextSpan(
                      text: "Sudah punya akun? ",
                      style: TextStyle(color: Colors.white),
                      children: <TextSpan>[
                    TextSpan(
                        text: "Masuk",
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
