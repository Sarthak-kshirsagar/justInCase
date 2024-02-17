import 'package:flutter/material.dart';


Widget inputTextField(TextEditingController c,TextInputType inputType,labelText,IconData i){
  return Container(
      width: 250,
      height: 100,
      child:TextField(
        controller: c,
        keyboardType: inputType,
        decoration: InputDecoration(
          label: Text("${labelText}"),
          icon: Icon(i),
        ),
      )
  );
}