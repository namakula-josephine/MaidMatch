import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//import 'package:lottie/lottie.dart';
import '../utils/app_styles.dart';
import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';


class GetOrderDetails extends StatelessWidget {
  final String documentId;

  GetOrderDetails(this.documentId);
 

      bool visible_cancel = true;
       bool visible_complete = true;
  @override
  Widget build(BuildContext context) {
    CollectionReference orders = FirebaseFirestore.instance.collection('orders');

     Stream<QuerySnapshot> streamOrders() {
    return orders.where('phoneNumber', isEqualTo:  '${documentId}').snapshots();
  } 

    return FutureBuilder<DocumentSnapshot>(
      future: orders.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
           final startdate =DateFormat('yyyy-MM-dd').format(data['date'].toDate().toLocal()).toString();
           if (data['status']=='In Progress'){
            visible_cancel =true;
            visible_complete=true;
           }else{
             visible_cancel =false;
            visible_complete=false;
           }
          return Column(
            children: [
                ListTile(
                    title: Text(data['category']??''),
                    subtitle: Text(data['status']??''),
                  ),
           
          
            ],
          );
        }

        return Text("loading");

        
      },
    );
  }
}


class OrderDetails extends StatefulWidget {
  final String userId;
  final String orderId;

  OrderDetails({required this.userId, required this.orderId});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

     final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('maid');
   Stream<QuerySnapshot> streamOrders() {
    return userCollection.where('phoneNumber', isEqualTo:  '${widget.userId}').snapshots();
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
           
              return Column(
                children: [  
                       Center(
        child: CircleAvatar(
          radius: 80, // Adjust the size as needed
          backgroundImage: Image.network(data['profilePic']??"https://cdn.vectorstock.com/i/preview-1x/66/14/default-avatar-photo-placeholder-profile-picture-vector-21806614.jpg").image,
        ),
      ),
                  ListTile(
                    title: Text(data['name']??''),
                    subtitle: Text(data['phoneNumber']??''),
                  ),GetOrderDetails(widget.orderId)
                ],
              );   

            }).toList(),
          );
        },

      ),
    );
  }
}
