import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projecthack/Sections/Porfile/profilePage.dart';

class SettingPage extends StatefulWidget {

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Settings",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:30),),
              SizedBox(height: 20,),
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //       border: Border.all(color: Colors.white,width:1),
              //       boxShadow: [
              //         BoxShadow(color: Colors.grey,blurStyle: BlurStyle.outer,spreadRadius:1,blurRadius:3),
              //       ]
              //   ),
              //   child: InkWell(
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context) => ManageProfile(oldMobile: "${widget.oldMobile}",oldName: "${widget.oldName}", oldEmail: widget.oldEmail),));
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceAround,
              //         children: [
              //           CircleAvatar(
              //             radius: 30,
              //             backgroundImage: widget.localImgPath.isNotEmpty
              //                 ? FileImage(File(widget.localImgPath))
              //                 : null, // Only set the backgroundImage if localImgPath is not empty
              //             child: widget.localImgPath.isEmpty
              //                 ? Icon(Icons.person,size:50,) // Show a loading indicator while the image is loading
              //                 : null, // No child if not loading
              //           ),
              //           Text("Sarthak",style: TextStyle(fontWeight: FontWeight.bold,fontSize:21)),
              //           Icon(Icons. arrow_forward_ios_sharp,size: 25),
              //         ],
              //
              //       ),
              //     ),
              //   ),
              //
              // ),
              SizedBox(height:20,),
              Text("App Settings",style: TextStyle(fontWeight: FontWeight.bold,fontSize:20)),
              SizedBox(height: 20,),
              listWidgtes(ProfilePage(),Icons.privacy_tip_rounded,"Privacy"),
              listWidgtes(ProfilePage(),Icons.backup_outlined,"Data Backup"),
              listWidgtes(ProfilePage(),Icons.money,"Set Currency"),
              listWidgtes(ProfilePage(),Icons.language_rounded,"Language"),

            ],
          ),
        ),
      ),
    );
  }

  Widget listWidgtes(Widget w, IconData i, text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          // color: Colors.grey,
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => w,
                ));
          },
          child: Row(
            children: [
              Icon(i, size: 35),
              SizedBox(
                width: 20,
              ),
              Text("${text}"),
            ],
          ),
        ),
      ),
    );
  }
}