import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/signin_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MoviesList"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Bienvenido a",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              "assets/MoviesList.png",
              width: 300.0, // Ajusta el tamaño según tus necesidades
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SigninScreen()),
                    );
                  },
                  child: const Text("Iniciar sesión"),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Puedes agregar la navegación a la pantalla de registro aquí
                  },
                  child: const Text("Registrarse"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}