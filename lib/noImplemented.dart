import 'package:flutter/material.dart';

class NotImplemented extends StatefulWidget {
  const NotImplemented({super.key});

  @override
  State<NotImplemented> createState() => _NotImplementedState();
}

class _NotImplementedState extends State<NotImplemented> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Not implemented yet"),
      ),
    );
  }
}
