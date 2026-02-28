import 'package:flutter/material.dart';

class BottomProfile extends StatefulWidget {
  const BottomProfile({super.key});

  @override
  State <BottomProfile> createState() =>  _BottomProfileState();
}

class _BottomProfileState extends State <BottomProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.4,
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://avtpbqenszsiyfzfyezl.supabase.co/storage/v1/object/public/storage/profile.png'),
            )
          ),
          SizedBox(
             height: MediaQuery.of(context).size.height * 0.02,
          ),
          Container(alignment: Alignment.center, child: Text('Имя')),
          Container(alignment: Alignment.center, child: Text('Почта')),
          InkWell(child: Text('Редактирование'), onTap: () {}),
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
                ,]
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.05,
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
        ],
      ),
    );
  }
}