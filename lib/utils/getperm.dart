import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getperm extends StatelessWidget {
  final String documentId;

  getperm({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference maids =
        FirebaseFirestore.instance.collection("users");
    return FutureBuilder<DocumentSnapshot>(
      future: maids.doc(documentId).get(),
      builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return Text('datat: ${data['name']}');
      }
      return Text('loading...');
    }));
  }
}
