import 'package:flutter/material.dart';
import 'package:flutter_application_1_test/bottom/bottom_home.dart';
import 'package:flutter_application_1_test/bottom/bottom_listing.dart';
import 'package:flutter_application_1_test/bottom/bottom_profile.dart';
import 'package:flutter_application_1_test/bottom/bottom_search.dart';
import 'package:flutter_application_1_test/database/service.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int index = 0;
  AuthService authService = AuthService();
  final screens = [
    BottomHome(),
    BottomSearch(),
    BottomSell(),
    BottomProfile(),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: screens.elementAt(index),
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: Colors.orange,
        onTap: (p0) {
          setState(() {
            index = p0;
          });
        },
        currentIndex: index,
        items: [
          SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
          SalomonBottomBarItem(icon: Icon(Icons.search), title: Text('Search')),
          SalomonBottomBarItem(icon: Icon(Icons.sell), title: Text('Sell')),
          SalomonBottomBarItem(icon: Icon(Icons.person), title: Text('Profile')),
        ]
      ),
    );
  }
}