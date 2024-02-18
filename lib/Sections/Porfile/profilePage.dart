import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projecthack/Sections/Dashboard/dashboard.dart';
import 'package:projecthack/Sections/Porfile/settings.dart';

import 'feedback.dart';
import 'helpSection.dart';
import 'manageProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  smallContainer(HelpScreen(),Icons.help, "Help"),
                  smallContainer(feedBackPage(),Icons.feedback_rounded, "Feedback")
                ],
              ),
              Divider(),
              Column(
                children: [
                  listWidgtes( AboutPage(), Icons.person, "Personal"),
                  listWidgtes( AboutPage(), Icons.mobile_friendly, "About App"),
                  listWidgtes(DashboardUi(), Icons.message, "Messages / Support"),
                  listWidgtes(SettingPage(), Icons.settings_suggest_rounded,
                      "Settings"),
                  listWidgtes(DashboardUi(), Icons.rule, "Legal"),
                  // listWidgtes(AboutUS(), Icons.info_rounded, "About Us"),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    // color: Colors.grey,
                  ),
                  child: InkWell(
                    onTap: () {
                      // signOut();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout, size:31),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Log Out"),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              Container(
                width: 400,
                child: AboutListTile(
                  applicationName: "BillWise",
                  applicationVersion:"1.0.0.1",
                  applicationLegalese: "© 2023 JustInCase.",
                  dense: true,
                  icon:Icon(Icons.info,size:31,color: Colors.black,),
                  child: Text("About JustInCase",style: TextStyle(fontSize: 14)),
                  applicationIcon: Icon(Icons.account_balance),
                  aboutBoxChildren: [

                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
  Widget smallContainer(Widget w,IconData icon, t) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                w));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(icon),
              Text("${t}"),
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
