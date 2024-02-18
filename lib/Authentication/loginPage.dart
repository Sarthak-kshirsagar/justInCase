import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projecthack/Authentication/registerUsingEmail.dart';
import 'package:projecthack/Authentication/registerUsingPhone.dart';
import 'package:projecthack/Authentication/utils/authentaicationUtils.dart';
import 'package:projecthack/main.dart';

import '../widgets/textfields.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void redirect(){
    setState(() {
      isSigningIn = false;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage(),));
  }
bool isSigningIn = false;
  Future<void>loginUser(emailAddress,password)async{
    setState(() {
      isSigningIn = true;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password

      ).then((value) =>  Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage(),)));
    } on FirebaseAuthException catch (e) {
      setState(() {
        isSigningIn=false;
      });
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text("Login"),
              SizedBox(height: 15,),
              Container(
                  height: 80,child: Image.asset("assets/logo.png")),

              SizedBox(height: 30,),
              SizedBox(height:10),
              Material(
                // color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                elevation: 10,
                child: Padding(
                  padding:  EdgeInsets.all(18.0),
                  child: Container(
                    width: 250,
                    height:400,
                    decoration:BoxDecoration(

                      // color: Colors.grey,
                    ) ,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [

                            Container(

                              child: Column(
                                children: [
                                  Text("Login using Email Address",style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  )),

                                  SizedBox(height: 20,),
                                  inputTextField(emailAddressController,TextInputType.emailAddress,"Enter Email Address",Icons.email),
                                  SizedBox(height: 20,),
                                  inputTextField(password,TextInputType.text,"Enter Password",Icons.password_rounded),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(style: ButtonStyle(
                                          backgroundColor: MaterialStatePropertyAll(Colors.black),
                                          foregroundColor: MaterialStatePropertyAll(Colors.white),
                                        ),onPressed: (){
                                          print(emailAddressController.text);
                                          loginUser(emailAddressController.text.trim(),password.text.trim());
                                        }, child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [

                                            Text("Login"),


                                          ],
                                        )),
                                        if(isSigningIn==true)
                                          SizedBox(width: 20,),
                                        if(isSigningIn==true)
                                          CircularProgressIndicator(),
                                      ],
                                    ),
                                  ),
                                  //login woth google
                                  SizedBox(height: 20,),
                                  // ElevatedButton(onPressed: (){
                                  //   signInWithGoogle(context);
                                  // }, child:Row(
                                  //
                                  //   children: [
                                  //
                                  //     Icon(Icons.login),
                                  //     SizedBox(width: 20,),
                                  //     Text("Signin using google")
                                  //   ],
                                  // )),
                                  Text("Not yet Registerd ?",style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 16,
                                  ),),
                                  ElevatedButton(style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                                  ),onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUsingEmail(),));
                                  }, child: Text("Register Now")),
                                ],
                              ),
                            ),
                          // if(showEmailPage==false)
                          //   RegisterUsingPhoneNumber(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
