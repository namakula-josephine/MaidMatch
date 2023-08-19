// import 'dart:math';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../comp/custom_button.dart';
import '../utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Babysitform extends StatefulWidget {
  const Babysitform({super.key});

  @override
  State<Babysitform> createState() => _BabysitformState();
}

class _BabysitformState extends State<Babysitform> {
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  DateTime? starttime;
   DateTime? endtime;
  DateTime? selecteddate;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Styles.backgColor,
        body: SafeArea(child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20,),
          children:[
            Gap(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Styles.backgColor
              ),
              child: Text("Babysitter order here please!",
              style: Styles.headlineStyle,
              textAlign: TextAlign.center,
              ),
            ),
            Gap(50),
            DateTimeFormField(
                decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'Request date',
              ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  selecteddate = value;
              },
            ),
            Gap(30),
            DateTimeFormField(
                decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'Start time',
              ),
                mode: DateTimeFieldPickerMode.time,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  starttime =value;
              },
            ),
            Gap(30),
            DateTimeFormField(
                decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.black45),
                errorStyle: TextStyle(color: Colors.redAccent),
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event_note),
                labelText: 'End time',
              ),
                mode: DateTimeFieldPickerMode.time,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  endtime = value;
              },
            ),
            Gap(30),
            Container(
              child: Text("calculated hours", style: TextStyle(
                color: Colors.black26,
                fontSize: 15,
              ),),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orange,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            Gap(30),
            Container(
              child: Text("calculated price", style: TextStyle(
                color: Colors.black26,
                fontSize: 15,
              ),),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orange,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            Gap(30),
            customButton(
              text: "submit",
             onPressed: ()async{
            
              final userId = _auth.currentUser?.uid;
               if ( selecteddate != null &&  endtime != null &&  starttime != null ){
                final id = userId !+ DateTime.now().toString();
                    // Create a new document in the `Users` collection with the user's id as the document id.
         await   db.collection("orders").doc('${id}').set({
           
               'date':selecteddate,
                'start-time':starttime,
                'end-time':endtime,
                'userid':userId,
               'id': id,
                'maid_id':'',
                'category':'Baby Sitter',
                 'status':'Pending'
               });
                 Fluttertoast.showToast(
        msg: 'Order made succesfully',
 
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
     Navigator.pop(context);
               } else {
                Fluttertoast.showToast(
        msg: 'Please Select all the fields',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
               }
            
             })
          ],
        )),
    );
  }
}