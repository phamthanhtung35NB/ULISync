import 'package:flutter/material.dart';
// import '../controller/login_controller.dart';
import 'package:ulis_ync/controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = LoginController();

  Future<void> _login() async {
    String? result = await _loginController.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (result != null) {
      if (result.length == 28) { // Assuming UID is 28 characters long
      //   if (result.length > 1) { // Assuming UID is 28 characters long
        Navigator.pushNamed(context, '/home_screen', arguments: result);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful. UID: $result')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100.0,
              child: Image(
                image: AssetImage('assets/images/ulislogo.png'),
              ),
            ),
            const SizedBox(height: 50.0),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Đăng nhập'),
            ),
          ],
        ),
      ),
    );
  }
}