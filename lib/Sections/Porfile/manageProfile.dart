import 'package:flutter/material.dart';
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'App Name',
                style: TextStyle(
                  fontSize: 18
                  ,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'BillWise',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Version',
                style: TextStyle(
                  fontSize: 18
                  ,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                '1.0.0',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Developer',
                style: TextStyle(
                  fontSize: 18
                  ,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'justInCase',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Description',
                style: TextStyle(
                  fontSize: 18
                  ,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Introducing "BillWise" – your go-to financial companion! With predictive budgeting via ARIMA models, automatic community tagging, seamless UPI integration, and detailed expense analyses, managing your money has never been simpler. ',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}