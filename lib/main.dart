import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projecthack/Authentication/registerUsingEmail.dart';

import 'Authentication/loginPage.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(MaterialApp(
    home: LandingPage(),
  ));
}


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  bool registerPage=true;
  bool loginPage = true;
  void switchBetweenRegisterLogin(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Welcome to the homePage")),
         SizedBox(height: 10,),
         Container(
           child: Row(
             // mainAxisAlignment: MainAxisAlignment.spaceAround,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUsingEmail(),));
               }, child: Text("Register")),
               SizedBox(width: 20,),
               ElevatedButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
               }, child: Text("Login Page"),),
             ],
           ),
         )

        ],
      )),
    );
  }
}
