import 'package:flutter/material.dart';
class HelpContent {
  final String question;
  final String answer;

  HelpContent({
    required this.question,
    required this.answer,
  });
}
class HelpScreen extends StatelessWidget {
  final List<HelpContent> helpContents = [
    HelpContent(
      question: 'How does the Expense Tracker simplify my spending habits?',
      answer: 'Effortlessly categorize and track your expenses in real-time, providing a clear overview of your financial patterns.',
    ),
    HelpContent(
      question: 'What insights can I gain from the Financial Dashboard?',
      answer: 'Gain actionable insights into your spending, set achievable financial goals, and monitor your savings effortlessly.',
    ),
    HelpContent(
      question: 'How can the Smart Finance Hub enhance my financial knowledge?',
      answer: 'Elevate your financial literacy with expert tips, personalized chatbot assistance, and interactive tools for informed decision-making.',
    ),

    // Add more help contents as needed
  ];
  double Fontdouble =40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(

        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height:20,),
              Text(
                textAlign: TextAlign.center,
                "Help",
                style: TextStyle(
                  fontSize:Fontdouble,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25,),
              Container(
                width: MediaQuery.of(context).size.width,
                height:500,
                child: ListView.builder(
                  itemCount: helpContents.length,
                  itemBuilder: (context, index) {
                    return HelpExpansionTile(helpContent: helpContents[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HelpExpansionTile extends StatelessWidget {
  final HelpContent helpContent;

  HelpExpansionTile({required this.helpContent});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ExpansionTile(

        title: Text(
          helpContent.question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              helpContent.answer,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}