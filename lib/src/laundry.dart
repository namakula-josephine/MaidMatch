import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gap/gap.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maidmatch_app/comp/custom_button.dart';

import '../utils/app_styles.dart';

class Laundryform extends StatefulWidget {
  const Laundryform({super.key});

  @override
  State<Laundryform> createState() => _LaundryformState();
}

class _LaundryformState extends State<Laundryform> {
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final List<String> category = [
  'Light-Many',
  'Light-Few',
  'Heavy-Many',
  'Heavy-Few',
  ];

  String? selectedValue;
  DateTime? selectedtime;
  DateTime? selecteddate;
  String status = "pending";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Styles.backgColor,
        body: SafeArea(child: ListView(
          
          padding: EdgeInsets.symmetric(horizontal: 20,),
          children:[
            Gap(20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Styles.backgColor
              ),
              child: Text("Laundry order here please!",
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
                labelText: 'Request time',
              ),
                mode: DateTimeFieldPickerMode.time,
                autovalidateMode: AutovalidateMode.always,
                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                onDateSelected: (DateTime value) {
                  selectedtime = value;
              },
            ),
            Gap(30),
             DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                // Add Horizontal padding using menuItemStyleData.padding so it matches
                // the menu padding when button's width is not specified.
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // Add more decoration..
              ),
              hint: const Text(
                'Select your laundry category',
                style: TextStyle(fontSize: 14),
              ),
              items: category
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select category.';
                }
                
                return null;
              },
              onChanged: (value) {
                selectedValue = value.toString();
                //Do something when selected item is changed.
              },
              onSaved: (value) {
                selectedValue = value.toString();
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
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
             onPressed:  () async{

              final userId = _auth.currentUser?.uid;
               if (selectedValue != null && selecteddate != null &&  selectedtime != null ){
                final id = userId !+ DateTime.now().toString();
                    // Create a new document in the `Users` collection with the user's id as the document id.
            await   db.collection("orders").doc('${id}').set({
                'quantity':selectedValue,
                'date':selecteddate,
                'start-time':selectedtime,
                'userid':userId,
                 'maid_id':'',
                'id': id,
                'category':'Laundry',
                 'status':'Pendings'
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