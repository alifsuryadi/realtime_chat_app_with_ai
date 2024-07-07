import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();
  String _errorMessage = '';

  void _register() async {
    setState(() {
      _errorMessage = '';
    });

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _errorMessage = 'Password dan konfirmasi password tidak cocok';
      });
      return;
    }

    if (_nameController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Nama tidak boleh kosong';
      });
      return;
    }

    if (!_validateEmail(_emailController.text)) {
      setState(() {
        _errorMessage = 'Format email tidak valid';
      });
      return;
    }

    if (!_validatePassword(_passwordController.text)) {
      setState(() {
        _errorMessage = 'Password harus lebih dari 6 karakter';
      });
      return;
    }

    bool success = await _authService.register(
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil mendaftar!')),
      );
      Navigator.pop(context);
    } else {
      setState(() {
        _errorMessage = 'Gagal mendaftar';
      });
    }
  }

  bool _validateEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegExp.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length > 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Mendaftar',
        style: TextStyle(fontFamily: "Caros"),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Mendaftar dengan Email",
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
                  "Daftarlah di aplikasi kami dan mulailah mengobrol dengan kecerdasan buatan dalam bahasa Minang!",
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
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama kamu',
                  labelStyle: TextStyle(
                      color: Color(0xFF24786D),
                      fontFamily: 'Circular-Book',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
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
              const SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi kata sandi',
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
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      left: 100, right: 100, top: 10, bottom: 10),
                  backgroundColor: const Color(0xFF24786D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Mendaftar',
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
                        builder: (context) => const LoginScreen()),
                  );
                },
                child: RichText(
                    text: const TextSpan(
                        text: "Sudah punya akun? ",
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                      TextSpan(
                          text: "Masuk",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF24786D)))
                    ])),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
