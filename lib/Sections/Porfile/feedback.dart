import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class feedBackPage extends StatefulWidget {
  const feedBackPage({super.key});

  @override
  State<feedBackPage> createState() => _feedBackPageState();
}

class _feedBackPageState extends State<feedBackPage>   {
  Future<String> fetchCurrentUserName()async{
    final FirebaseAuth auth = await FirebaseAuth.instance;
    final User? currentUserAuthInfo = await auth.currentUser;
    final String? currentUserUid = await currentUserAuthInfo?.uid.toString();
    print("Printing the current user id ${currentUserUid}");


    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUserUid)
        .get();
// ========================

    if (documentSnapshot.exists) {
      // Retrieve the "name" field
      String? userName = await documentSnapshot.get("Name");
      print("got the name is name is ${userName}");

      return userName!;
    } else {
      // Document does not exist
      print('Document with ID  does not exist.');
      return "no data";
    }
  }
  Future<void>collectFeedback(String feedback)async{
    CollectionReference ref = await FirebaseFirestore.instance.collection("Feedbacks");
    String userName = await fetchCurrentUserName();
    try {
      if(feedback.toString().isNotEmpty){
        await ref.doc().set({
          "User Name":"${userName}",
          "Feedback":"${feedback}",
        }).then((value){
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              icon: Icon(Icons.check,color: Colors.green,size: 50),
              shape: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey)),
              backgroundColor: Colors.grey[200],
              contentPadding: EdgeInsets.all(0),
              content: Container(
                width: 150,
                height:90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Feedback sent !",style: TextStyle(fontWeight: FontWeight.bold)),

                  ],
                ),
              ),
            );
          },);
        });
      }else{
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            icon: Icon(Icons.error,color: Colors.red,size: 50),
            shape: OutlineInputBorder(

                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey)),
            backgroundColor: Colors.grey[200],
            contentPadding: EdgeInsets.all(0),
            content: Container(
              width: 150,
              height:90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Please enter the feedback.",style: TextStyle(fontWeight: FontWeight.bold)),


                ],
              ),
            ),
          );
        },);
      }
    } on Exception catch (e) {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.error,color: Colors.red,size: 50),
          shape: OutlineInputBorder(

              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey)),
          backgroundColor: Colors.grey[200],
          contentPadding: EdgeInsets.all(0),
          content: Container(
            width: 150,
            height:90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Failed To send",style: TextStyle(fontWeight: FontWeight.bold)),

              ],
            ),
          ),
        );
      },);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                "Feedback",
                style: TextStyle(
                  fontSize:40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height:20,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width:MediaQuery.of(context).size.width,

                    child: ClipRRect(borderRadius: BorderRadius.circular(30),child: Image(image: AssetImage("assets/feedBackGif.gif")))),
              ),

              Container(
                  child:Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width:MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: FeedBackController,
                            key: FormKey,
                            maxLines:3,
                            onChanged: (value) {
                              FeedBackController.text = value;
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return "Please write something";
                              }
                            },
                            decoration: InputDecoration(

                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey,width: 1.5)
                                ),
                                label: Text("Please write your Suggestions")
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(Colors.white)
                      ,backgroundColor: MaterialStatePropertyAll(Colors.black)),

                  onPressed: () {

                    print("dalbli");
                    collectFeedback(FeedBackController.text);
                  }

                  , child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
  final FormKey = GlobalKey<FormState>();
  TextEditingController FeedBackController = new TextEditingController();
}