import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/auth_page.dart';
import 'package:flutter_application_1_test/bottom/profile/notifications.dart';
import 'package:flutter_application_1_test/check.dart';
import 'package:flutter_application_1_test/home.dart';
import 'package:flutter_application_1_test/recovery_page.dart';
import 'package:flutter_application_1_test/reg_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://avtpbqenszsiyfzfyezl.supabase.co',
    anonKey: 'sb_publishable_DmcdXMt6QUZ_W1sISgutEA_-RBXcxVm',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benova',
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false, // remove debug banner
      initialRoute: '/',
      routes: {
        '/':(context)=>CheckPage(),
        '/auth':(context)=>AuthPage(),
        '/reg': (context) => RegPage(),
        '/home': (context) => HomePage(),
        '/recovery': (context) => RecoveryPage(),
        '/notifications' : (context) => NotificationsPage(),
      }, 
    );
  }
}

