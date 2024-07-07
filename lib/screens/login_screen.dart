import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'chat_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Masuk',
          style: TextStyle(fontFamily: 'Caros'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Masuk ke AmboAI",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontFamily: 'Caros',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Selamat datang kembali! Masuk menggunakan akun sosial atau email Anda untuk melanjutkan",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontFamily: 'Circular-Book',
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset(
                      "assets/images/icons/facebook-icon-white.png"),
                  onPressed: () {
                    // Handle Facebook login
                  },
                ),
                IconButton(
                  icon:
                      Image.asset("assets/images/icons/google-icon-white.png"),
                  onPressed: () async {
                    bool success = await _authService.signInWithGoogle();
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Berhasil masuk dengan Google!')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatScreen()),
                      );
                    } else {
                      setState(() {
                        _errorMessage = 'Gagal masuk dengan Google!';
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Image.asset("assets/images/icons/apple-icon-white.png"),
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
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                const Text(
                  "Atau",
                  style: TextStyle(color: Colors.black),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email kamu',
                labelStyle: TextStyle(
                    color: Color(0xFF24786D),
                    fontFamily: 'Circular-Book',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Kata sandi',
                labelStyle: TextStyle(
                    color: Color(0xFF24786D),
                    fontFamily: 'Circular-Book',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                bool success = await _authService.signIn(
                  _emailController.text,
                  _passwordController.text,
                );
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Berhasil masuk!')),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatScreen()),
                  );
                } else {
                  setState(() {
                    _errorMessage = 'Gagal masuk!';
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(
                    left: 150, right: 150, top: 10, bottom: 10),
                backgroundColor: Color(0xFF24786D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Masuk',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Caros',
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()),
                );
              },
              child: RichText(
                  text: const TextSpan(
                      text: "Belum punya akun? ",
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text: "Daftar",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF24786D)))
                  ])),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
