import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maidmatch_app/comp/custom_button.dart';
import 'package:maidmatch_app/provider/auth_provider.dart';
import 'package:maidmatch_app/src/home.dart';
import 'package:maidmatch_app/src/signin.dart';
import 'package:provider/provider.dart';

import '../utils/app_styles.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap =Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Styles.backgColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: [ SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/wel.jpg",
                  height: 250,
      
                  ),
                  Gap(30),
                  Text("Welcome to MaidMatch", style: Styles.headlineStyle2, textAlign: TextAlign.center, ),
                  Gap(10),
                  Text("Service Above Self", style: Styles.headlineStyle4,textAlign: TextAlign.center, ),
      
                  Gap(60),
      
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: customButton(text: "Let's Go",  
                    onPressed: (){
                      ap.isSignedIn == true?//when true, then fetch shared preferences data
                       Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => const  homeScreen(),))
                      :Navigator.push(context, MaterialPageRoute(builder: (context) => const signIn(),));
                    }),
                  )
                ],
              ),
               ),
          ),
        )],
      ),
  
    );
  }
}