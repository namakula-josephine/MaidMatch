import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:maidmatch_app/comp/custom_button.dart';
import 'package:maidmatch_app/model/user_model.dart';
import 'package:maidmatch_app/provider/auth_provider.dart';
import 'package:maidmatch_app/src/home.dart';
import 'package:maidmatch_app/utils/utils.dart';
import 'package:provider/provider.dart';

import '../utils/app_styles.dart';


class Userinfo extends StatefulWidget {
  const Userinfo({super.key});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  File? image;
  final nameContoller = TextEditingController();
  final emailContoller = TextEditingController();
  final bioContoller = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameContoller.dispose();
    emailContoller.dispose();
    bioContoller.dispose();
  }


  //for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {

        final isLoading = 
    Provider.of<AuthProvider>(context, listen:true).isLoading;
    return Scaffold(
      backgroundColor: Styles.backgColor,
      body: SafeArea(
        child:ListView(
          padding: const EdgeInsets.symmetric(horizontal:10 , vertical: 25),
          children:[
                        isLoading == true? const Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              )):
            InkWell(
              onTap: ()=>selectImage() ,
              child: image == null ? const CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                radius: 50,
                child: Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.white,
                ),
              ):CircleAvatar(
                backgroundImage: FileImage(image!),
                radius: 50,
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  //name field 
                  textField(
                    hintText: "Enter your name",
                     icon: Icons.account_circle, 
                     inputType: TextInputType.name,
                      maxLines: 1, 
                      controller: nameContoller),
                  //email field
                    textField(
                    hintText: "Enter email (abc@example.com)",
                    icon: Icons.email, 
                    inputType: TextInputType.name,
                    maxLines: 1, 
                    controller: emailContoller),
                  //bio data field
                    textField(
                    hintText: "Enter your bio",
                    icon: Icons.edit, 
                    inputType: TextInputType.name,
                    maxLines: 2, 
                    controller: bioContoller),

                ],
              ),
            ),
            Gap(20),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.90,
              child: customButton(text: "Continue", onPressed: () => storeData()),
            ),

          ]
        ) ),

    );
  }
  Widget textField({
    required String hintText, 
    required IconData icon, 
    required TextInputType inputType, 
    required int maxLines, 
    required TextEditingController controller
    }){
    return Padding(padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      cursorColor: Colors.blueAccent,
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
          color: Colors.blueAccent,
          ),
          child: Icon(icon,size: 20, color: Colors.white,),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide( color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide( color: Colors.transparent),
        ),
        hintText: hintText,
        alignLabelWithHint: true,
        border: InputBorder.none,
        fillColor: const Color.fromARGB(255, 255, 184, 90),
        filled: true,

      ),
    ),
    );
  }
void storeData () async {
  final ap = Provider.of<AuthProvider>(context, listen: false);
  UserModel userModel = UserModel(
    name: nameContoller.text.trim(), 
    email: emailContoller.text.trim(), 
    bio: bioContoller.text.trim(), 
    profilePic: "", 
    createdAt: "", 
    phoneNumber: "",
    uid: ""
     );
     if (image!=null){
      ap.saveUserDatatoFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess:(){
          ap.saveUserDataToSP().then((value) => Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context)=> const homeScreen()), (route) => false));
        },
      );
     }else{
      showSnackBar(context, "Please upload your profile photo");
     }

}

}