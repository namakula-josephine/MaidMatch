import 'package:flutter/material.dart';
import 'package:maidmatch_app/src/babysit.dart';
import 'package:maidmatch_app/src/check.dart';
import 'package:maidmatch_app/src/clean.dart';
import 'package:maidmatch_app/src/custom.dart';
import 'package:maidmatch_app/src/laundry.dart';

import '../utils/app_styles.dart';

class bookpage1 extends StatefulWidget {
  const bookpage1({super.key});

  @override
  State<bookpage1> createState() => _bookpage1State();
}

class _bookpage1State extends State<bookpage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "MAID MATCH",
          style: Styles.headlineStyl,
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      backgroundColor: Styles.backgColor,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Laundryform())));
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/laundry.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Cleanform())));
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        child: ClipOval(
                          child: Image.asset(
                            "assets/cleaner2.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Checkout()),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Icon(Icons.shopping_cart, size: 100),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Babysitform())));
                      },
                    child: Container(
                      width: 150,
                      height: 150,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/babysit.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Customform())));
                      },
                    child: Container(
                      width: 150,
                      height: 150,
                      child: const Center(
                        child: Text(
                          "CUSTOM\nORDER",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
