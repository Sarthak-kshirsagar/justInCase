import 'package:flutter/material.dart';
import 'package:projecthack/Authentication/registerUsingPhone.dart';
import 'package:projecthack/Authentication/utils/authentaicationUtils.dart';

import '../widgets/textfields.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Text("Login"),
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
                                ElevatedButton(style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                                ),onPressed: (){
                                  print(emailAddressController.text);
                                }, child: Text("Login")),
                                //login woth google
                                SizedBox(height: 20,),
                                ElevatedButton(onPressed: (){
                                  signInWithGoogle(context);
                                }, child:Row(
                    
                                  children: [
                    
                                    Icon(Icons.login),
                                    SizedBox(width: 20,),
                                    Text("Signin using google")
                                  ],
                                ))
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
      )),
    );
  }
}
