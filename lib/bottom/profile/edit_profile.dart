import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/database/service.dart';
import 'package:flutter_application_1_test/database/storage/storage.dart';
import 'package:flutter_application_1_test/database/user_table/user_table.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePage extends StatefulWidget {
  dynamic docs;
  EditProfilePage({super.key, this.docs});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  UserTable userTable = UserTable();
  String user_id = Supabase.instance.client.auth.currentUser!.id;
  String? url;
  File? _selectedfile;
  XFile? _file;
  StorageCloud storageCloud = StorageCloud();
  AuthService authservice = AuthService();

  Future<void> selectedImageGallery() async {
    final returnimage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _selectedfile = File(_selectedfile!.path);
      _file = returnimage;
    });
  }

  Future<void> uploadImage() async {
    try {
      await storageCloud.addImageCloud(_file!);
    } catch (e) {
      return;
    }
  }

  Future<void> downloadUrl() async {
    try {
      final fileName = path.basename(_file!.path);
      final image = await Supabase.instance.client.storage
          .from('storage')
          .getPublicUrl(fileName);

      setState(() {
        url = image;
      });
    } catch (e) {
      return;
    }
  }

  Future<void> pushImageSupabase() async {
    try {
      showDialog(
        context: context,
        builder: (context) =>
            Center(child: CircularProgressIndicator(color: Colors.orange)),
      );
      await uploadImage();
      await Future.delayed(Duration(seconds: 4));
      await downloadUrl();

      await userTable.updateImage(url!, user_id);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text("Успешное сохранение"),
          backgroundColor: Color.fromARGB(156, 27, 12, 34),
        ),
      );
    } catch (e) {
      return;
    }
  }

  @override
  void initState() {
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            CircleAvatar(
              backgroundImage: NetworkImage(widget.docs['avatar']),
              radius: 60,
              backgroundColor: Colors.grey[300],
            ),

            TextButton.icon(
              onPressed: () async {
                await selectedImageGallery();
              },
              icon: Icon(
                Icons.add_photo_alternate,
                color: Colors.orange,
                size: 20,
              ),
              label: Text(
                'Add photo',
                style: TextStyle(color: Colors.orange, fontSize: 16),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(color: Colors.orange),
                controller: fullnamecontroller,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "Fullname",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                style: TextStyle(color: Colors.orange),
                controller: emailcontroller,
                readOnly: true,
                cursorColor: Colors.orange,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  labelText: "Email",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

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
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.045,
              child: ElevatedButton(
                onPressed: () async {
                  if (_selectedfile != null && fullnamecontroller.text.isNotEmpty) {
                    await pushImageSupabase();
                    await userTable.updateName(fullnamecontroller.text, user_id);
                    Navigator.pop(context);
                  }
                  else {
                    if (_selectedfile != null && fullnamecontroller.text == widget.docs['full_name']){
                      await pushImageSupabase();
                      Navigator.pop(context);
                    }
                    else {
                      if (_selectedfile == null && fullnamecontroller.text != widget.docs['full_name']){
                        await userTable.updateName(fullnamecontroller.text, user_id);
                        Navigator.pop(context);
                      }
                      else{
                        if (_selectedfile == null && fullnamecontroller.text == widget.docs['full_name']){
                          Navigator.pop(context);
                        }
                      }
                    }
                  }
                },
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(25),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Colors.orange),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
