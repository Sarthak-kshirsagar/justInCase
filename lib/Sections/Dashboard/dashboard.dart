import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:info_popup/info_popup.dart';
import 'package:info_widget/info_widget.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../utilities/models.dart';
import '../InfoScreens/info1.dart';
import '../InfoScreens/info2.dart';
import '../InfoScreens/info3.dart';
import '../Porfile/helpSection.dart';

class DashboardUi extends StatefulWidget {
  const DashboardUi({super.key});

  @override
  State<DashboardUi> createState() => _DashboardUiState();
}

class _DashboardUiState extends State<DashboardUi> {
  double dailyExpense = 0.0;
  double monthlyExpense = 0.0;
  double yearlyIncome = 0.0;


  Future<void> fetchData() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;// Replace with your actual user ID
    dailyExpense=0.0;
    monthlyExpense=0.0;
    yearlyIncome=0.0;
    try {
      // Query to get the Payments document with the matching UID
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('Payments')
          .where('userId', isEqualTo: userId)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through the documents (there should be only one for the given UID)
        querySnapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> docSnapshot) {
          // Get the data from the document
          Map<String, dynamic> data = docSnapshot.data()!;

          // Access dailyExpense and add numeric values to the total
          Map<String, dynamic> dailyExpenses = data['dailyExpense'] ?? {};
          dailyExpenses.forEach((String date, dynamic amount) {
            // Check if amount is numeric before adding to the total
            if (amount is num) {
              setState(() {
                dailyExpense += amount.toDouble();
                print(dailyExpense);
              });
            }
          });

          // // Access monthlyCategory and add to the total
          // Map<String, dynamic> monthlyCategories = data['monthlyCategory'] ?? {};
          // monthlyCategories.forEach((String month, dynamic value) {
          //   // Check if value is numeric before adding to the total
          //   if (value is num) {
          //     setState(() {
          //       monthlyExpense += value.toDouble();
          //       print("hi");
          //       print(monthlyExpense);
          //     });
          //   }
          // });
          Map<String, dynamic> monthlyCategories = data['monthlyCategory'] ?? {};

// Specify the month you want to retrieve, e.g., 'Feb'
          String targetMonth = 'Feb';

// Check if the target month exists in the map
          if (monthlyCategories.containsKey(targetMonth)) {
            dynamic value = monthlyCategories[targetMonth];

            // Check if value is numeric before adding to the total
            if (value is num) {
              setState(() {
                monthlyExpense += value.toDouble();
                print("hi");
                print(monthlyExpense);
                print("hi");
              });
            }
          } else {
            // Handle the case where the target month doesn't exist
            print('Target month $targetMonth not found in monthlyCategory');
          }

          // Access yearlyExpense and add to the total
          Map<String, dynamic> yearlyExpenses = data['yearlyCategory'] ?? {};
          yearlyExpenses.forEach((String year, dynamic value) {
            // Check if value is numeric before adding to the total
            if (value is num) {
              setState(() {
                yearlyIncome += value.toDouble();
                print(yearlyIncome);
              });
            }
          });
        });
      } else {
        print('No document found for user: $userId');
      }
    } catch (e) {
      print('Error fetching expense data: $e');
    }
  }




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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    // fetchExpenseData("6scHAN7yriZuPxa3A7FhIaqtfRy1");
  }
  Future<void> _refreshData() async {
    // Simulate a delay to mimic fetching new data from a data source
    await Future.delayed(Duration(seconds: 2));
    await  fetchData();

    // Add new items or update the data here

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(


            body:RefreshIndicator(
              color: Colors.red.shade300,
              onRefresh: _refreshData,
              child: ListView(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20,),   //for header
                            Container(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Align(
                                      alignment:Alignment.centerLeft,
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage("assets/profilePic.jpg"),
                                        ),
                                        decoration: BoxDecoration(
                                          // color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width:30,),
                                    Text("Home",style: TextStyle(
                                      fontWeight: FontWeight.bold,fontSize:20,
                                    ),),
                                    SizedBox(width:30,),

                                    InkWell(
                                      onTap: ()async{
                                        dynamic conversationObject = {
                                          'appId': '42a8079ddc31228631ca83451d5c18d',// The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                                        };

                                        KommunicateFlutterPlugin.buildConversation(conversationObject)
                                            .then((clientConversationId) {
                                          print("Conversation builder success : " + clientConversationId.toString());
                                        }).catchError((error) {
                                          print("Conversation builder error : " + error.toString());
                                        });
                                      },
                                      child: Container(
                                        width:60,
                                        height: 60,
                                          child: Image.asset("assets/chatbot.png"),
                                      ),
                                    )
                                  ],
                                )
                            ),
                            //for main card
                            SizedBox(height: 50,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                elevation: 42,
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),

                                // color: Colors.black87,
                                child: Container(
                                    width:400,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.black87,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,

                                        ),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Available Balance",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18
                                          ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("25000",style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30
                                          ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Sarthak Kshirsagar",style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16
                                              ),),
                                              Icon(Icons.account_balance,size: 50,color: Colors.white,)
                                            ],
                                          ),
                                        )

                                      ],
                                    )
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),
                            //for daily statistics
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Prediction",style:TextStyle(
                                      fontWeight: FontWeight.bold,fontSize: 22,
                                    ),),
                                    SizedBox(width: 20,),
                                    InfoPopupWidget(
                                      contentTitle: 'Based on ARIMA using\nlast 5 transactions',
                                      child: Icon(
                                        Icons.help,
                                        color: Colors.pink,
                                      ),
                                    ),

                                  ]
                                  ,
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                              width: 350,
                              height: 250,
                              color: Colors.grey,
                              child: Container(
                                  child: SfCartesianChart(
                                    backgroundColor: Colors.white,
                                      primaryXAxis: CategoryAxis(),
                                      series: <CartesianSeries>[
                                        LineSeries<ChartData, String>(
                                            dataSource: [
                                              ChartData('Day1', 35, Colors.red),
                                              ChartData('Day2', 35, Colors.red),
                                              ChartData('Day3', 35, Colors.red),
                                              ChartData('Day4', 34, Colors.green),
                                              ChartData('Day5', 36, Colors.green)
                                            ],
                                            // Bind the color for all the data points from the data source
                                            pointColorMapper:(ChartData data, _) => data.color,
                                            xValueMapper: (ChartData data, _) => data.x,
                                            yValueMapper: (ChartData data, _) => data.y
                                        )
                                      ]
                                  )
                              ),
                            ),

                            SizedBox(height: 20,),
                            Container(
                              width: 450,
                              height: 120,

                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    showExpenses(Colors.purple.shade200,Icons.group,"Daily Expense", "${dailyExpense}"),
                                    SizedBox(width: 20,),
                                    showExpenses(Colors.red.shade100,Icons.calendar_month,"Monthly Expense", "${monthlyExpense}"),
                                    SizedBox(width: 20,),
                                    showExpenses(Colors.green.shade100,Icons.money,"Yealry Expense", "${yearlyIncome}"),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Our Services",style:TextStyle(
                                fontWeight: FontWeight.bold,fontSize: 22,
                              ),),
                            ),
                            Container(
                              width: 350,
                              height: 500,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    explore(context,"assets/ExpenseT.jpg","Expense Tracking \n and Categorization","Track and categorize expenses effortlessly, keeping you in control of your financial journey with ease.",Service1()),
                                    explore(context,"assets/dashboard.jpg","Financial Analytics\nDashboard","Visualize spending, set goals, and monitor savings. Make informed financial decisions with our dynamic analytics dashboard.",Service2()),
                                    explore(context,"assets/chatbotIm.jpg","Financial Literacy\nHub","Boost financial literacy with expert tips, a dedicated chatbot, and interactive insights. Elevate your financial IQ for a secure future.",Service3()),



                                  ],
                                ),
                              ),
                            )
                            // Container(
                            //   width: 300,
                            //   height: 100,
                            //   color: Colors.red.shade200,
                            //   child: SingleChildScrollView(
                            //     scrollDirection: Axis.horizontal,
                            //     child: Row(
                            //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //       children: [
                            //         SizedBox(width:20,),
                            //         Container(
                            //           width: 50,
                            //           height: 50,
                            //           color: Colors.white,
                            //
                            //         ),
                            //         SizedBox(width:20,),
                            //         Container(
                            //           width: 50,
                            //           height: 50,
                            //           color: Colors.white,
                            //
                            //         ),
                            //         SizedBox(width:20,),
                            //         Container(
                            //           width: 50,
                            //           height: 50,
                            //           color: Colors.white,
                            //
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // )
                            ,SizedBox(height:20,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Help",
                                  style: TextStyle(
                                    fontSize:20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25,),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height:300,
                              child: ListView.builder(
                                itemCount: helpContents.length,
                                itemBuilder: (context, index) {
                                  return HelpExpansionTile(helpContent: helpContents[index]);
                                },
                              ),
                            ),

                            Container(
                              width: 350,
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.analytics,size: 40,),
                                  Container(width: 60,height: 60,child: Image.asset("assets/chatbot.png")),
                                  Icon(Icons.account_balance,size: 40,),


                                ],
                              ),
                            )


                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
    );

  }
  Widget showExpenses(Color c1,IconData i,heading,money){
    return  Material(

      // elevation: 20,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: (){},

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            height: 100,
            decoration: BoxDecoration(
                color: c1,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Icon(i,color: Colors.black,),
                  Text("${money}",style:TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 22,
                  ),),
                  Text("${heading}",style:TextStyle(
                    fontWeight: FontWeight.bold,fontSize:15,
                  ),),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget explore(BuildContext context,String path,String heading,String Content,Widget Route){
    return InkWell(
      onTap: (){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Route));
      },
      child: Padding(

        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 460,
          decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(color: Colors.grey,offset:Offset(0,0),blurRadius:8,spreadRadius:0,blurStyle: BlurStyle.outer),                  ],
            // border: Border.all(color: Colors.black,width: 1),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(00),topRight:Radius.circular(70),bottomLeft: Radius.circular(30)),
          ),
          width:250,
          // height:200,
          child:Column(

            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(00),topRight:Radius.circular(70),bottomLeft:Radius.circular(0)),child: Image.asset(fit: BoxFit.fitWidth,height: 250,width:250,path)),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(textAlign: TextAlign.center,heading,style: TextStyle(fontWeight: FontWeight.bold,fontSize:17),),
                    SizedBox(width:10,),
                    Icon(Icons.arrow_forward,size:30,),
                  ],

                ),
              ),

              Padding(

                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                    height:100,
                    child: Text(Content,style:TextStyle(fontSize:15,))),
              ),

            ],
          ) ,
        ),
      ),
    );
  }
}
