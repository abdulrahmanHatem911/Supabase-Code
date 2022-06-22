import 'package:flutter/material.dart';
import 'package:supabase_pro2/screen/home_screen.dart';
import 'package:supabase_pro2/screen/login_screen.dart';
import 'package:supabase_pro2/screen/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'signup',
      routes: {
        '/home': (_) => HomeScreen(),
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignupScreen(),
    );
  }
}
