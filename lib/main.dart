import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/welcome_screen.dart';

// IMPORTS DE FIREBASE
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const MyApp()) ;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true
      ).copyWith(
        scaffoldBackgroundColor: const Color(0xFF333333),
      ),
      home: const WelcomeScreen()
    );
  }
}




