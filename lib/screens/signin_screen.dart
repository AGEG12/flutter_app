import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';


class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar sesión en"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text(
          "Movies List",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20.0),
        Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                },
                child: const Text("Iniciar sesión"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}