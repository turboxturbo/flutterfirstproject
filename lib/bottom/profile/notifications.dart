import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  String user_id = Supabase.instance.client.auth.currentUser!.id;

  Widget tileNotifications(BuildContext context, dynamic docs){
    return ListTile(
      title: Text(docs['title']),
      subtitle: Text(docs['body']),
      leading: Icon(Icons.notifications),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Уведомления"),
        leading: IconButton(onPressed: () 
        {
          Navigator.popAndPushNamed(context, '/home');
        }, icon: Icon(Icons.arrow_back_ios)),
      ),

      body: StreamBuilder(
        stream: Supabase.instance.client.from('notifications').stream(primaryKey: ['id']).eq('user_id', user_id),
        builder: (context, snapshot){
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(color: Colors.orange),
            );
          }

          var not = snapshot.data;

          return ListView.builder(
            itemBuilder: (context, index){
              return tileNotifications(context, not![index]);
            },
            itemCount: not!.length,
          );
        },
      ),
    );
  }
}