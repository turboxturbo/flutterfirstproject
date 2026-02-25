import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/database/service.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RecoveryPagesState();
}

class _RecoveryPagesState extends State<RecoveryPage> {
  TextEditingController emailController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox (
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  style: TextStyle(
                    color: Colors.black
                  ),
                  controller: emailController,
                  cursorColor: Colors.orange,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: Colors.black
                    ),
                    labelText: 'Email',
                   focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.black),
                    )
                  ),
                ),
              ),
              SizedBox (
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox (
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.045,
                child: ElevatedButton(
                  onPressed: () async{
                  if(emailController.text.isNotEmpty){
                    await authService.recoveryPassword(emailController.text);
                    Navigator.popAndPushNamed(context, '/');
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Заполните поле"),
                      backgroundColor: Colors.black,)
                    );
                  }
                  
                },
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(25),
                    )),
                    backgroundColor: WidgetStatePropertyAll(Colors.orange),
                  ),
                  child: Text(
                    'Recovery',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/auth');
                },
                child: Text('Back', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
 }
}