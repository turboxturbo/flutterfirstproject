import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(
                  color: Colors.black),
                controller: fullnamecontroller,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelText: "Fullname",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black)
                  )
                ),
              )
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(
                  color: Colors.orange),
                controller: passwordcontroller,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelText: "Email",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black)
                  )
                ),
              )
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(
                  color: Colors.orange),
                controller: passwordcontroller,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelText: "Password",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black)
                  )
                ),
              )
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.045,
              child: ElevatedButton(
                onPressed: () async {}, 
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(25),
                    )),
                    backgroundColor: WidgetStatePropertyAll(Colors.orange),
                ),
                child: Text(
                  'Save', 
                  style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}