import 'package:flutter/material.dart';
import 'package:projecthack/Authentication/utils/authentaicationUtils.dart';
import 'package:projecthack/widgets/textfields.dart';
class RegisterUsingPhoneNumber extends StatefulWidget {
  const RegisterUsingPhoneNumber({super.key});

  @override
  State<RegisterUsingPhoneNumber> createState() => _RegisterUsingPhoneNumberState();
}

class _RegisterUsingPhoneNumberState extends State<RegisterUsingPhoneNumber> {
  bool isLoading =false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500,
      child: Column(
        children: [
          Text("Register using Phone Number",style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          )),

          SizedBox(height: 20,),
          inputTextField(phoneNumber,TextInputType.emailAddress,"Enter Phone Number",Icons.email),
          SizedBox(height: 20,),
          // inputTextField(TextInputType.text,"Enter Password",Icons.password_rounded),
          // SizedBox(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              ElevatedButton(style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
              ),onPressed: ()async{
                setState(() {
                  isLoading = true;
                  print("upadting the stateeeee");
                });
                 phoneNumberAuthentication(context);
                setState(() {
                  isLoading = false;
                });
              }, child: Text("Request OTP")),

              if(isLoading==true)

                CircularProgressIndicator()
            ],
          ),
        ],
      ),
    );

  }
}
