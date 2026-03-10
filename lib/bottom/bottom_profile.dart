import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/bottom/profile/edit_profile.dart';
import 'package:flutter_application_1_test/database/service.dart';
import 'package:flutter_application_1_test/database/storage/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BottomProfile extends StatefulWidget {
  const BottomProfile({super.key});

  @override
  State <BottomProfile> createState() =>  _BottomProfileState();
}

class _BottomProfileState extends State <BottomProfile> {
  final userid = Supabase.instance.client.auth.currentUser!.id;
  dynamic docs;
  String? url;
  File? _selectedfile;
  StorageCloud storageCloud = StorageCloud();
  AuthService authservice = AuthService();
  Future<void> getUserById()async{
    try{
      var user = await Supabase.instance.client.from('users').select().eq('id', userid).single();

      setState(() {
        docs = user;
      });
    }
    catch(e){
      return;
    }
  }

  Future<void> selectedImageGallery()async{
    final returnimage = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedfile = File(_selectedfile!.path);
    });
  }

  @override
    void initState(){
      getUserById();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.4,
            child: CircleAvatar(
              backgroundImage: NetworkImage(docs['avatar'])
            )
          ),
          // TextButton.icon(onPressed: () async {
          //   await selectedImageGallery();
          // }, 
          // icon: Icon(
          //   Icons.add_photo_alternate,
          //   color: Colors.orange,
          //   size: 20,
          // ),
          // label: Text(
          //   'Add photo',
          //   style: TextStyle(color: Colors.orange, fontSize: 16),
          //   ),
          // ),

          SizedBox(
             height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(alignment: Alignment.center, child: Text(docs['full_name'])),
          Container(alignment: Alignment.center, child: Text(docs['email'])),
          InkWell(child: Text('Редактирование', style: TextStyle(color: Colors.blue),), onTap: () {
            Navigator.push(context, CupertinoPageRoute(builder: (context) => EditProfilePage(docs: docs)));
          }),
          SizedBox(
             height: MediaQuery.of(context).size.height * 0.04,
          ),
          Container(
            alignment: Alignment.topLeft, 
            padding: EdgeInsets.fromLTRB(35, 10, 10, 10),
            child: Text('Найстройки')
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text("Безопасность"),
                  ),
                  ListTile(
                    title: Text("Уведомления"),
                  )
                ]
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.045,
             child: ElevatedButton(
              onPressed: () {
                //Navigator.popAndPushNamed(context, '/home');
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(25),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(Colors.orange),
              ),
              child: Text('Разместить объявление', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
             )
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.045,
            child: ElevatedButton(
              onPressed: () async {
                await authservice.logOut();
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.popAndPushNamed(context, '/');
            }, 
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(25),
                )),
              backgroundColor: WidgetStatePropertyAll(Colors.orange),
            ),
            child: Text("Sing out", style: TextStyle(color: Colors.white),)),
          )
        ],
      ),
    );
  }
}