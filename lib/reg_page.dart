import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/database/service.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repeatPassController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // // дети по центру по вертикали
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: nameController,
                cursorColor: Colors.black, // мигающий курсор - черного цвета
                style: TextStyle(color: Colors.orange), // цвет текста при печати
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: 'Name', // Текст, который становиться плавающим лейблом (плавает вверх, когда начинаешь вводить)
                  
                  focusedBorder: OutlineInputBorder( // когда рамка находиться в фокусе (нажали)
                    borderRadius: BorderRadius.circular(25), // закругление углов
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder( // когда на рамку не нажимали 
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black26)
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,), // отступы между полями
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: phoneController,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.orange),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: 'Phone',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black26)
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,), // отступы между полями
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: emailController,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.orange),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: 'Email',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black26)
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: passController,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.orange),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: 'Password',
                  suffixIcon: IconButton( // иконка глаза (скрыт или не скрыт пароль)
                    onPressed: () {},
                    icon: Icon(Icons.visibility),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black26)
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: repeatPassController,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.orange),
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: 'Confirm password',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.visibility),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black26)
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),

            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: Alignment.center,
              child: InkWell( // делает любой виджет кликабельным с эффектом ripple (кружок при нажатии)
                child: Text('By registreing, you agree to the Terms of Use and Privacy Policy',
                style: TextStyle(color: Colors.blue,
                fontSize: 13,
                 ),
                ),
                onTap: () {}, // перехож на экран восстановления  
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.045,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton( // — это кнопка с подъёмом / тенью (Material 3 стиль)
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll( // значение применяется ко всем состоянием кнопки 
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(25),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Colors.orange),
                ),
                onPressed: () async {
                  if (nameController.text.isNotEmpty && emailController.text.isNotEmpty
                  && phoneController.text.isNotEmpty && passController.text.isNotEmpty
                  && repeatPassController.text.isNotEmpty){
                    if (passController.text == repeatPassController.text){
                      var user = await authService.singUp(emailController.text, passController.text);
                      if(user != null){
                        Navigator.popAndPushNamed(context, '/');
                      }else{

                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Confirm password"),
                          backgroundColor: Colors.black,)
                        );
                    }
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Fill in all gaps"),
                          backgroundColor: Colors.black,)
                        );
                  }
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // // дети по центру по вертикали
              children: [
                Text(
                  "Already have account?"
                ),
                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/'); // переход к странице "Вход"
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}