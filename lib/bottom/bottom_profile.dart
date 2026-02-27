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
              backgroundImage: NetworkImage('');
            )
          ),
          SizedBox(
             height: MediaQuery.of(context).size.height * 0.2,
          ),
          Container(alignment: Alignment.center, child: Text('Имя')),
          Container(alignment: Alignment.center, child: Text('Почта')),
          InkWell(child: Text('Редактирование', onTap: () {}))
          SizedBox(
             height: MediaQuery.of(context).size.height * 0.04,
          ),
          Container(alignment: Alignment.topLeft, child: Text('Найстройки')),

          Card(
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

          SizedBox(
             child: ElevatedButton(
              onPressed: () {},
              child: Text('Разместить объявление', )
             )
          ),

        ],
      ),
    );
  }
}