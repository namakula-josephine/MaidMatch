import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    return userCollection.where('name').snapshots();
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
        body: StreamBuilder<QuerySnapshot>(
        stream: streamOrders(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if(snapshot.hasData){

          print(snapshot.data);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
            return ListView();






  }
  


  )
  
  
  );
  }
}
