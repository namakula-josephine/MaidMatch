import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//import 'package:lottie/lottie.dart';
import '../utils/app_styles.dart';
import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class OrderDetails extends StatefulWidget {
  final String userId;
  final String orderId;

  OrderDetails({required this.userId, required this.orderId});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

     final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('orders');
   Stream<QuerySnapshot> streamOrders() {
    return userCollection.where('id', isEqualTo:  '${widget.orderId}').snapshots();
  }   

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Styles.backgColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: streamOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
           print(snapshot.data!.docs.length);
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
    
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
    
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            final date = DateFormat('yyyy-MM-dd').format(data['date'].toDate()).toString();
            if (data['category']=='Laundry'){
              
              return ListTile(
                title: Text(data['quantity']??''),
                subtitle: Row(
                  children: [
                    Text('Start Date'),SizedBox(width: 20,),Text(date)
                  ],
                ),
              );}
               else if (data['category']=='Baby Sitter') {
                final startdate = DateFormat('h:mm a').format(data['start-time'].toDate()).toString();
              return ListTile(
                title: Text(data['quantity']??''),
                subtitle:  Row(
                  children: [
                    Text('Start Date'),SizedBox(width: 20,),Text(date),SizedBox(width: 40,),Text('Start time'),SizedBox(width: 20,),Text(startdate)
                  ],
                ),
              );}  
                else  {
              return ListTile(
                title: Text(data['category']??''),
                subtitle: Text(data['status']??''),
              );}
            }).toList(),
          );
        },
      ),
    );
  }
}
