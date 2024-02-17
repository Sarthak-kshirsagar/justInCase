import 'package:flutter/material.dart';




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
      appBar: AppBar(
        title: Text('UPI Parser'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              onChanged: (value) {
// Add onChanged callback to update the state
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Enter UPI Text',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String upiText = _textEditingController.text;
                parseUpiText(upiText);
              },
              child: Text('Parse UPI Text'),
            ),
            SizedBox(height: 20.0),
            Text(
              'UPI ID: ${upiId ?? "Not Found"}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Contains Merchant Text: $containsMerchantText',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
