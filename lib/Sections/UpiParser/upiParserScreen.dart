import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';

import 'dummy.dart';




//

//
//

//


class UpiScreenParser extends StatefulWidget {
  const UpiScreenParser({super.key});

  @override
  State<UpiScreenParser> createState() => _UpiScreenParserState();
}

class _UpiScreenParserState extends State<UpiScreenParser> {
  TextEditingController _textEditingController = TextEditingController();
  String? upiId;
  bool containsMerchantText = false;

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
//barcode scanner flutter ant
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    parseUpiText(_scanBarcode);
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  String _scanBarcode = 'Unknown';
  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  void parseUpiText(String upiText) {
// Extracting UPI ID
    RegExp regExp = RegExp(r'upi://pay\?pa=([^\&]+)');
    Match? match = regExp.firstMatch(upiText);
    if (match != null) {
      setState(() {
        upiId = match.group(1);
      });
    }

// Checking for 'merchant' text
    RegExp merchantRegExp = RegExp(r'merchant', caseSensitive: false);
    setState(() {
      containsMerchantText = merchantRegExp.hasMatch(upiText);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          
          
          child: Image.asset("assets/chatbot.png"),onPressed: ()async{ dynamic conversationObject = {
        'appId': '42a8079ddc31228631ca83451d5c18d',// The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
      };

      KommunicateFlutterPlugin.buildConversation(conversationObject)
          .then((clientConversationId) {
        print("Conversation builder success : " + clientConversationId.toString());
      }).catchError((error) {
        print("Conversation builder error : " + error.toString());
      });}),
      appBar: AppBar(
        title: Text('UPI Parser'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:CrossAxisAlignment.center ,
          children: <Widget>[


            SizedBox(height: 15,),
            Container(
                height: 80,child: Image.asset("assets/logo.png")),

            SizedBox(height: 30,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "Scan away, and let the magic of tracking your expenses begin!",
                  style: TextStyle(
                    fontSize:18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade400
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            Material(
              elevation:12,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [

                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(

                              onTap: (){
                                scanQR();
                              },child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.document_scanner_outlined,color: Colors.black,size: 50,),
                              )),
                          Text(
                            'UPI ID: ${upiId ?? "Not Found"}',
                            style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),


                      SizedBox(height: 20.0),
                      Text(textAlign: TextAlign.center,"Payment only acceptable if the receiver is registered Merchant",style:
                      TextStyle(
                          fontWeight: FontWeight.bold,fontSize:17,color: Colors.grey
                      ),),
                      SizedBox(height: 10.0),
                      Text(textAlign: TextAlign.center,"Scan the Qr Code for further process",style:
                      TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 15
                      ),),
                      SizedBox(height: 10.0),
                      Container(child: Divider()),
                      Text(
                        'Merchant Status : $containsMerchantText',
                        style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20,),
                      if(containsMerchantText==true)
                        ElevatedButton(

                            style: ButtonStyle(
                              foregroundColor: MaterialStatePropertyAll(Colors.white,),
                              backgroundColor: MaterialStatePropertyAll(Colors.black),

                            ),onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context) => UpiPaymentScreen(upiIdd: upiId.toString(),),));
                        }, child: Text("Pay Now")),

                      // ElevatedButton(onPressed: ()async{
                      //
                      //   dynamic conversationObject = {
                      //     'appId': '42a8079ddc31228631ca83451d5c18d',// The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                      //   };
                      //
                      //   KommunicateFlutterPlugin.buildConversation(conversationObject)
                      //       .then((clientConversationId) {
                      //     print("Conversation builder success : " + clientConversationId.toString());
                      //   }).catchError((error) {
                      //     print("Conversation builder error : " + error.toString());
                      //   });
                      //
                      // }, child: Text("Flutter"))
                    ],
                  ),
                ),
              ),
            ),

            // ElevatedButton(
            //     onPressed: () {
            //       scanQR();
            //
            //     },
            //     child: const Text('QR scan')),

            // Text("Link:- ${_scanBarcode}"),

        //             TextField(
        //
        //               controller: _textEditingController,
        //               onChanged: (value) {
        // // Add onChanged callback to update the state
        //                 setState(() {});
        //               },
        //               decoration: InputDecoration(
        //                 labelText: 'Enter UPI Text',
        //               ),
        //             ),



          ],
        ),
      ),
    );
  }
}
