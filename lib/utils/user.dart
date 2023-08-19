import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maidmatch_app/src/home.dart';
import 'package:maidmatch_app/src/welcome_scrn.dart';
//import 'package:maidsmatch_maids/homepage.dart';

class user extends StatelessWidget {
  const user({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

          body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (!snapshot.hasData){
                return homeScreen();
              }else {
                return welcomeScreen();
              }
            },
            ),
    );
  }
}