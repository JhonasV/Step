import 'dart:io';
import 'package:Step/screens/login_screen.dart';
import 'package:Step/screens/register_screen.dart';
import 'package:Step/ui/competencies/competencies_screen.dart';
import 'package:Step/screens/home_screen.dart';
import 'package:Step/ui/competencies/create_competencies.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = new MyHttpOverrides();
    return MaterialApp(
      title: "Step",
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        CompentenciesScreen.id: (context) => CompentenciesScreen(),
        CreateCompentenciesScreen.id: (context) => CreateCompentenciesScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegisterScreen.id: (context) => RegisterScreen()
      },
    );
  }
}
