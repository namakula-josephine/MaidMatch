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
  List<String> docIDs = [];

  Future docID() async {
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  @override
  void initState() {
    docID();
    // TODO: implement initState
    super.initState();
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
        body: Expanded(child:
            FutureBuilder<DocumentSnapshot>(builder: (context, snapshot) {
          return ListView.builder(
              itemCount: docIDs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: getperm(documentId: docIDs[index]),
                );
              });
        })));
  }
}
