import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  dynamic docs;
  EditProfilePage({super.key, this.docs});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  @override
  void initState(){
    fullnamecontroller.text = widget.docs['full_name'];
    emailcontroller.text = widget.docs['email'];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.docs['avatar']),
              radius: 60,
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(
                  color: Colors.orange),
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
                controller: emailcontroller,
                readOnly: true,
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
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.045,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.popAndPushNamed(context, '/recovery');
                }, 
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(25),
                    )),
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                child: Text(
                  'Password', 
                  style: TextStyle(
                  color: Colors.red, 
                  fontWeight: FontWeight.bold
                )),
              ),
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