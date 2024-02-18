import 'package:flutter/material.dart';
import 'package:projecthack/Authentication/loginPage.dart';
import 'package:projecthack/Authentication/registerUsingPhone.dart';
import 'package:projecthack/widgets/textfields.dart';
import 'package:projecthack/Authentication/utils/authentaicationUtils.dart';

class RegisterUsingEmail extends StatefulWidget {
  const RegisterUsingEmail({super.key});

  @override
  State<RegisterUsingEmail> createState() => _RegisterUsingEmailState();
}

class _RegisterUsingEmailState extends State<RegisterUsingEmail> {
  Color emailAddress = Colors.purple;
  Color phoneNumber = Colors.grey;
  bool showEmailPage=true;
  double registerContainerHeight = 350;
  bool isLoading = false;
  void showBorder(bool isClickedEmail,bool isClickedPassword){
        setState(() {
          if(isClickedEmail==true){
            emailAddress = Colors.purple;
            phoneNumber = Colors.grey;
            showEmailPage=true;
            registerContainerHeight =350;


          }else if(isClickedPassword==true){
            phoneNumber = Colors.purple;
            emailAddress = Colors.grey;
            showEmailPage=false;
            registerContainerHeight = 250;
          }
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: 800,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15,),
                  Container(
                      height: 80,child: Image.asset("assets/logo.png")),
              
                  SizedBox(height: 30,),
                      // toogle between registeremail and register using phone
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(
                      //   border: Border(bottom: BorderSide(color: Colors.grey,width: 1.5))
                      // ),
              
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            InkWell(
                              onTap: (){
                                showBorder(true, false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: emailAddress,width: 2))
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Email Address",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17
                                      )),
                                    ),
                                    SizedBox(width:20,)
              
                                  ],
                                ),
                              ),
              
                            ),
                          InkWell(
                            onTap: (){
                              showBorder(false, true);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color:phoneNumber,width: 2))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Phone Number",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17
                                    )),
                                  ),
              
                                ),
                                SizedBox(width:20,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 15,),
                      // ====ui for the showing the dialog box
                  Material(
                    // color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        width: 250,
                        height: registerContainerHeight,
                        decoration:BoxDecoration(
              
                          // color: Colors.grey,
                        ) ,
                        child: Column(
                          children: [
                            if(showEmailPage==true)
                              Container(
                                  height:350 ,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    children: [
                                      Text("Register using Email Address",style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      )),
              
                                      SizedBox(height: 20,),
                                      inputTextField(name,TextInputType.emailAddress,"Enter Full Name",Icons.person),
                                      SizedBox(height: 20,),
                                      inputTextField(emailAddressController,TextInputType.emailAddress,"Enter Email Address",Icons.email),
                                      SizedBox(height: 20,),
                                      inputTextField(password,TextInputType.text,"Enter Password",Icons.password_rounded),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(style: ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                                            foregroundColor: MaterialStatePropertyAll(Colors.white),
                                          ),onPressed: () async{
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                            await createUSerUsingEmailAddress(context,name.text,emailAddressController.text, password.text);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                            print("code for creating the user executed");
                                          }, child: Text("Register")),
                                          if(isLoading==true)
                                            CircularProgressIndicator(),
                                        ],
                                      ),
              
                                      Text("Already a user?",style: TextStyle(
                                        fontWeight: FontWeight.bold,fontSize: 16,
                                      ),),
                                      ElevatedButton(style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                                      ),onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                                      }, child: Text("Login")),
              
              
              
                                    ],
                                  ),
                                ),
                              ),
                            if(showEmailPage==false)
                              RegisterUsingPhoneNumber(),
                          ],
                        ),
                      ),
                    ),
                  ),
              
              
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

}
