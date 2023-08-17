import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maidmatch_app/src/babyba.dart';
import 'package:maidmatch_app/src/babysit.dart';

import '../utils/app_styles.dart';

class tab2 extends StatelessWidget {
  const tab2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            "MAID MATCH",
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Styles.backgColor,
        body: SafeArea(
          
          child: DefaultTabController
          (length: 2, 
            child: Column(
              children: <Widget> [
                Gap(10),
                ButtonsTabBar(
                backgroundColor: Colors.orangeAccent,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: TextStyle(color: Colors.black),
                labelStyle:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      text: "AVAILABLE MAIDS",
                      
                    ),
                    Tab(
                      text: "MAKE ORDER",
                      
                    )
                  ]),
                  Expanded(
                    child: TabBarView
                    (children: <Widget>[
                      babybasit(),
                      Babysitform()
                    ]),)
              ],
            )
            )));
  }
}