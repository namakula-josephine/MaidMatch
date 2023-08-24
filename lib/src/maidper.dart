import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maidmatch_app/comp/custom_button.dart';
import 'package:maidmatch_app/utils/getperm.dart';

import '../utils/app_styles.dart';

class maidperm extends StatefulWidget {
  const maidperm({super.key});

  @override
  State<maidperm> createState() => _maidpermState();
}

class _maidpermState extends State<maidperm> {
         final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('permanentAvail');


  // Stream documents where the 'status' field is equal to 'active'
  Stream<QuerySnapshot> streamOrders() {
    return userCollection.where('permanentAvail').snapshots();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            "MAID MATCH",
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Styles.backgColor,
        body:StreamBuilder<QuerySnapshot>(
        stream: streamOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
         
           Fluttertoast.showToast(
        msg: 's',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      if (!snapshot.hasData) {
              return Text('Loading...');}
              
         
              final List<QueryDocumentSnapshot> activeUsers = snapshot.data!.docs;
           //   return Text('Loading...');
           return    ListView.builder(
            itemCount: activeUsers.length,
            itemBuilder: (context, index) {
              final userData = activeUsers[index].data() as Map<String, dynamic>;
             
              return ListTile(
                title: Container(
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  child: Row(
                     
                    children: [
                      Column(
                        children: [
                          Gap(100),
                          Text("name:"),
                          Text("age:"),
                          Text("health status:"),
                          Text("location:"),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: 50,

                            child: Image.network(userData['photo'] ?? ''),
                          ),
                          SizedBox(width: 100),
                          Text(userData['name'] ?? ''),
                          SizedBox(width: 100),
                          Text(userData['age'] ?? ''),
                          SizedBox(width: 100),
                          Text(userData['health'] ?? ''),
                          SizedBox(width: 100),
                          Text(userData['residence'] ?? ''),
                          SizedBox(width: 100),
                        ],
                      ),
                      Column(
                        children:[
                          customButton(
                          text: "order", 
                          onPressed: (){})
                        ],
                      )
                     
                    ],
                  ),
                ),
            
                // ... other UI elements for each document
              );
            },
          );
            

        
        }
      ),
        );
  }
}
