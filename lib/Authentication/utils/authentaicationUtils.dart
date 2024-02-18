import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecthack/Authentication/loginPage.dart';
// import 'package:GoogleSignIn/SignInScreen.dart'
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projecthack/utilities/dateFunc.dart';
import '../../widgets/homeScreen.dart';
TextEditingController emailAddressController = new TextEditingController();
TextEditingController password = new TextEditingController();
TextEditingController phoneNumber = new TextEditingController();
TextEditingController name = new TextEditingController();


class User {
  String userId;
  String name;
  String email;

  User({required this.userId, required this.name, required this.email});
}


Future<void> addUserToFirestore(User user) async {
  try {
    await FirebaseFirestore.instance.collection('Users').doc(user.userId).set({
      'Name': user.name,
      'Email': user.email,
      "User Id":user.userId,
      // You can add more fields if needed
    });
    String currentMonth = getCurrentMonth();
    String currentYear = getCurrentYear();
    String currentDate = getCurrentDate();
    await FirebaseFirestore.instance.collection('Payments').doc(user.userId).set({

      "User Id":user.userId,
      "Daily Expense":{},
      "MonthlyExpense":{
        "${currentMonth}":0,

      },
      "YearlyExpense":{
        "${currentYear}":0,
      },
      // You can add more fields if needed
    });

    await FirebaseFirestore.instance.collection('CategorizeExpense').doc(user.userId).set({

      "userId":user.userId,
      "monthlyCategory":{
        "${currentMonth}":{
          "food":0.0,
            "stationary":0.0,
          "chai":0.0,
        },


      },
      "yearlyCategory":{
        "${currentYear}":{
          "food":0.0,
          "stationary":0.0,
          "chai":0.0,
        },

      },
      // You can add more fields if needed
    });
    await FirebaseFirestore.instance.collection('ShopWiseExpense').doc(user.userId).set({

      "User Id":user.userId,
      // You can add more fields if needed
    });

  } catch (e) {
    print('Error adding user to Firestore: $e');
    // Handle the error as needed
  }
}

Future<void>signout(BuildContext context)async{
  final FirebaseAuth auth = FirebaseAuth.instance;
  // String u = auth.currentUser!.uid;
  auth.signOut();
  print("doneeeee");
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
}

Future<void> signInWithGoogle(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  try {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential).then((value){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(userId: value.user!.uid),));
      print("done");
    });


    // final User? user = userCredential.user;
    // print(user);

    // Use the user object for further operations or navigate to a new screen.
  } catch (e) {
    print(e.toString());
  }
}

Future<void> createUSerUsingEmailAddress(BuildContext context,name,emailAddress,password)async{
  try {
    final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    // Get the user ID from the created user
    final userId = credential.user!.uid;

    // Create a User object with the required information
    User newUser = User(userId: userId, name:name, email: emailAddress);

    // Call the function to add the user to Firestore
    await addUserToFirestore(newUser).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginScreen(),)));

    print("User created successfully");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
Future<void> phoneNumberAuthentication(BuildContext context) async {
  final FirebaseAuth auth = FirebaseAuth.instance;

  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '+91 1111111111',
    verificationCompleted: (PhoneAuthCredential credential) {
      print("Verification completed");
      print("credential is ${credential}");
    },
    verificationFailed: (FirebaseAuthException e) {
      print("Verification Failed ${e}");
    },
    codeSent: (String verificationId, int? resendToken) async {
      String smsCode = "777888";
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode.trim(),
      );

      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential).then((value) {
        String uid = value.user?.uid ?? ''; // Extract UID from UserCredential

        // Navigate to the next screen and pass the UID
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(userId: uid),
          ),
        );
      });
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}


// function to implement the google signin

// creating firebase instance
final FirebaseAuth auth = FirebaseAuth.instance;
// final FirebaseAuth auth = FirebaseAuth.instance;



// Future<void> phoneNumberAuthentication(BuildContext context)async{
//   final FirebaseAuth auth =FirebaseAuth.instance;
//   await FirebaseAuth.instance.verifyPhoneNumber(
//     phoneNumber: '+91 1111111111',
//     verificationCompleted: (PhoneAuthCredential credential) {
//       print("Verification completed");
//       print("credential is ${credential}");
//     },
//     verificationFailed: (FirebaseAuthException e) {
//       print("Verification Failed ${e}");
//     },
//     codeSent: (String verificationId, int? resendToken) async{
//       String smsCode = "777888";
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode.trim());
//           print("code sent ");
//       // Sign the user in (or link) with the credential
//       await auth.signInWithCredential(credential).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(userId:value.toString()),)));
//
//     },
//     codeAutoRetrievalTimeout: (String verificationId) {},
//   );
// }