import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:maidmatch_app/src/check.dart';
import 'package:maidmatch_app/src/home.dart';
import 'package:maidmatch_app/src/notifications.dart';
import 'package:maidmatch_app/src/profile.dart';

class hiddenMenu extends StatefulWidget {
  const hiddenMenu({super.key});

  @override
  State<hiddenMenu> createState() => _hiddenMenuState();
}

class _hiddenMenuState extends State<hiddenMenu> {

  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home', 
          baseStyle: TextStyle(), 
          selectedStyle: TextStyle(),
          ), 
        homeScreen()),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'My Orders', 
          baseStyle: TextStyle(), 
          selectedStyle: TextStyle(),
          ), 
        checkout()),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Notifications', 
          baseStyle: TextStyle(), 
          selectedStyle: TextStyle(),
          ), 
        notificationsPage()),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'My information', 
          baseStyle: TextStyle(), 
          selectedStyle: TextStyle(),
          ), 
        profilePage())
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorAppBar: Colors.orange,
      backgroundColorMenu: Colors.orangeAccent.shade100,
      screens: _pages,
      initPositionSelected: 0,
      slidePercent: 70,
      
    );
  }
}