// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/database/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPagesState();
}

class _AuthPagesState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/logo.png', 
              fit: BoxFit.contain, 
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: emailController,
                  cursorColor: Colors.orange,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Email',
                    //hintText: 'Введите email',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black26),
                    )
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  cursorColor: Colors.orange,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Password',
                    //hintText: 'Введите password',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black26),
                    )
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.center,
                child: InkWell(
                  child: Text('Forgot the password', style: TextStyle(color: Colors.blue),),
                  onTap: (){
                    Navigator.popAndPushNamed(context, '/recovery');
                  },
                  
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(25),
                    )),
                    backgroundColor: WidgetStatePropertyAll(Colors.orange),
                  ),
                  onPressed: () async{
                    if (emailController.text.isNotEmpty && passController.text.isNotEmpty){
                      var user = await authService.singIn(emailController.text, passController.text);
                      if (user != null){
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);
                        Navigator.popAndPushNamed(context, '/');
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Пользователь не найден"),
                          backgroundColor: Colors.black,)
                        );
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Заполните все поля"),
                          backgroundColor: Colors.black,)
                        );
                    }
                  }, 
                  child: Text(
                    'Sign in', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have account?"),
                    TextButton(onPressed: () {
                      Navigator.popAndPushNamed(context, '/reg');
                    }, child: Text("Sign up", style: TextStyle(color: Colors.blue)),)
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
