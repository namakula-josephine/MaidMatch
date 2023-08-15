import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class checkout extends StatefulWidget {
  const checkout({super.key});

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
final _auth = FirebaseAuth.instance;
   
final Stream<QuerySnapshot> _usersStream =
   FirebaseFirestore.instance
              .collection('Laundry order')
              .where('userid', isEqualTo:  '${FirebaseAuth.instance.currentUser?.uid}')
              .snapshots();
     final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Laundry order');

  // Stream documents where the 'status' field is equal to 'active'
  Stream<QuerySnapshot> streamOrders() {
    return userCollection.where('userid', isEqualTo:  '${FirebaseAuth.instance.currentUser?.uid}').snapshots();
  }         
  List<String> selectedItems = []; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: streamOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(snapshot.data?.docs.first);
           Fluttertoast.showToast(
        msg: '${snapshot.data?.docs.length} orders',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      if (!snapshot.hasData) {
              return Text('Loading...');}
                final List<QueryDocumentSnapshot> activeUsers = snapshot.data!.docs;
          if (snapshot.hasData) {
           //   return Text('Loading...');
           return    ListView.builder(
            itemCount: activeUsers.length,
            itemBuilder: (context, index) {
              final userData = activeUsers[index].data() as Map<String, dynamic>;
               var date = userData['date'];
               if (date != null){
                   date = DateFormat('yyyy-MM-dd').format(userData['time'].toDate().toLocal()).toString()+'         '+DateFormat('h:mm a').format(userData['date'].toDate()).toString();
               } else {
                date = '';
               }
              return ListTile(
                title: Text(userData['quantity'] ?? ''),
                subtitle: Text(date ?? ''),
                // ... other UI elements for each document
              );
            },
          );
            }
           if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
          return Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 15) ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 223, 235, 235),
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        width: 150,
                        height: 150,
                        child:LottieBuilder.asset("assets/cart.json",
                            height: 90,
                            width: 90,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'CHECK\nOUT\nORDER',
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'TOTAL AMOUNT : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'UGX 50,000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red, 
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                ),

            
              ],
            ),
          );
        }
      ),
    );
  }
}
