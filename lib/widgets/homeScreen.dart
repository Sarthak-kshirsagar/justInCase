import 'package:flutter/material.dart';
import 'package:projecthack/Authentication/utils/authentaicationUtils.dart';

class HomeScreen extends StatefulWidget {
  String userId;
   HomeScreen({required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome"),
            Text("${widget.userId}"),
            ElevatedButton(onPressed: (){
                    signout(context);
            }, child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
