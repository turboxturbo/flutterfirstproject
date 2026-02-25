import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1_test/auth_page.dart';
import 'package:flutter_application_1_test/home.dart';

class CheckPage extends StatefulWidget{
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage>{
  bool _isLoggedIn = false;
  Future<void> _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(
      (){
        _isLoggedIn = isLoggedIn;
      }
    );
  }

  @override
  void initState(){
    _checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return _isLoggedIn ? HomePage() : AuthPage();
  }
}