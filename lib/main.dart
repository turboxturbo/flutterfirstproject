import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/auth_page.dart';
import 'package:flutter_application_1_test/reg_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benova',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false, // remove debug banner
      initialRoute: '/',
      routes: {
        '/':(context)=>AuthPage(),
        '/reg': (context) => RegPage(),
      },
    );
  }
}

