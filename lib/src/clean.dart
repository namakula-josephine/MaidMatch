import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
//import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import '../comp/custom_button.dart';
import '../utils/app_styles.dart';

class Cleanform extends StatefulWidget {
  const Cleanform({super.key});

  @override
  State<Cleanform> createState() => _CleanformState();
}

class _CleanformState extends State<Cleanform> {
final TextEditingController _nameController = TextEditingController();

    final List<String> category = [
    '1-5',
    '',
    '',
    'CUSTOM ',
    ];
 final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  DateTime? starttime;
   DateTime? endtime;
  DateTime? selecteddate;
  int? rooms;
    String? selectedValue;
    DateTime? selectedtime;
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
              child: Text("House cleaning order here please!",
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
                  starttime = value;
              },
            ),
            Gap(30),

             
          TextFormField(
                decoration: InputDecoration(labelText: 'Enter Number of rooms'),
                keyboardType: TextInputType.number,
             controller: _nameController,
                
                validator: (value) {
                  if (value==null) {
                    'Please enter a value.';
                  }
                   selectedValue = value;
                  return null;
                },
                onSaved: (value) {
                  selectedValue = value;
                },
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
      rooms = int.parse(_nameController.text);
              final userId = _auth.currentUser?.uid;
               if ( selecteddate != null &&  starttime != null &&  rooms != null ){
                final id = userId !+ DateTime.now().toString();
                    // Create a new document in the `Users` collection with the user's id as the document id.
         await   db.collection("orders").doc('${id}').set({
           'rooms':rooms,
               'date':selecteddate,
                'start-time':starttime,
                'userid':userId,
                'maid_id':'',
               'id': id,
                'category':'House Clean',
                 'status':'Pendinggf'
               });
                 Fluttertoast.showToast(
        msg: 'Order Placed Succesfully',
 
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
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    super.dispose();
  }

}