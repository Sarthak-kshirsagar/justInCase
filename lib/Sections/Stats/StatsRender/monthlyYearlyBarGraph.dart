import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'models.dart';

class MonthlyYearlyBarGraph extends StatefulWidget {
  const MonthlyYearlyBarGraph({super.key});

  @override
  State<MonthlyYearlyBarGraph> createState() => _MonthlyYearlyBarGraphState();
}

class _MonthlyYearlyBarGraphState extends State<MonthlyYearlyBarGraph> {
  List<BarChartData> data = [
    BarChartData(
      "Jan",2500,
    ),
    BarChartData(
      "Feb",3500,
    ),
    BarChartData(
      "March",4500,
    ),
    BarChartData(
      "Apr",3500,
    ),
  ];

  late TooltipBehavior _tooltipBehavior;
  List<BarChartData> yearlyData = [
    BarChartData(
      "2022",2500,
    ),
    BarChartData(
      "2023",3500,
    ),

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
    _tooltipBehavior =  TooltipBehavior(

        enable: true,activationMode: ActivationMode.singleTap);
  }
  Color monthlyExp = Colors.purpleAccent;
  Color yearlyExp = Colors.grey;
  bool showMonthlyGraph=true;
  double registerContainerHeight = 350;
  bool isLoading = false;
  List<BarChartData> yearlyDataA = [];
  Future<List<BarChartData>> fetchDataFromFirestore() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        // Fetch data from Firestore
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
            .collection('Payments')
            .where('User Id', isEqualTo: userId)
            .get();

        List<BarChartData> data = [];
        List<BarChartData> yearlyData = [];

        // Iterate through the documents and create BarChartData objects
        querySnapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> document) {
          // Accessing the data in the Monthly subcollection
          Map<String, dynamic> monthlyData = document['monthlyCategory'] ?? {};
          Map<String,dynamic>yearlyDataa = document['yearlyCategory']??{};

          // Iterate through the monthly data and create BarChartData objects
          monthlyData.forEach((String month, dynamic value) {
            // Convert value to double if it's not already
            double doubleValue = value is int ? value.toDouble() : value;
            data.add(BarChartData(month, doubleValue));
          });

          yearlyDataa.forEach((String year, dynamic value) {
            // Convert value to double if it's not already
            double doubleValue = value is int ? value.toDouble() : value;
            yearlyData.add(BarChartData(year, doubleValue));
          });

        });
        setState(() {
          yearlyDataA=yearlyData;
        });

        return data;
      } else {
        print('User not logged in.');
        // Handle the case where the user is not logged in
        return [];
      }
    } catch (e) {
      print('Error fetching data from Firestore: $e');
      // Handle the error as needed
      return [];
    }
  }
  List<BarChartData> fetchedData=[];
  void initialize()async{
    List<BarChartData>feetchedData = await fetchDataFromFirestore();
    setState(() {
      fetchedData = feetchedData;
    });
    print(feetchedData);
  }
  void showBorder(bool isClickedEmail,bool isClickedPassword){
    setState(() {
      if(isClickedEmail==true){
        monthlyExp = Colors.purple;
        yearlyExp = Colors.grey;
        showMonthlyGraph=true;
        registerContainerHeight =350;


      }else if(isClickedPassword==true){
        yearlyExp = Colors.purple;
        monthlyExp = Colors.grey;
        showMonthlyGraph=false;
        registerContainerHeight = 250;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                "Overall Expense",
                style: TextStyle(
                  fontSize:25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 40,),
          Container(
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   border: Border(bottom: BorderSide(color: Colors.grey,width: 1.5))
            // ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    showBorder(true, false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: monthlyExp,width: 2))
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Monthly Expense",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                          )),
                        ),
                        SizedBox(width:20,)

                      ],
                    ),
                  ),

                ),
                InkWell(
                  onTap: (){
                    showBorder(false, true);
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:yearlyExp,width: 2))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Yearly Expense",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                          )),
                        ),

                      ),
                      SizedBox(width:20,)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          if(showMonthlyGraph==true)
          Container(
            child:Center(
              child: Container(
                  child: SfCartesianChart(

                      borderColor: Colors.red,
                      tooltipBehavior: _tooltipBehavior,
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries<BarChartData,String>>[
                        // Renders column chart

                        ColumnSeries<BarChartData, String>(
                            dataSource: [
                              BarChartData("Feb", 1500),
                            ],
                            enableTooltip: true,

                            xValueMapper: (BarChartData data, _) => data.month,
                            yValueMapper: (BarChartData data, _) => data.amount
                        )
                      ]
                  )
              ),
            ),
          ),
          if(showMonthlyGraph==false)

            Container(
              child:Center(
                child: Container(
                    child: SfCartesianChart(

                        borderColor: Colors.red,
                        tooltipBehavior: _tooltipBehavior,
                        primaryXAxis: CategoryAxis(),
                        series: <CartesianSeries<BarChartData,String>>[
                          // Renders column chart

                          ColumnSeries<BarChartData, String>(
                              dataSource: [
                                BarChartData("Feb", 1500),
                              ],
                              enableTooltip: true,

                              xValueMapper: (BarChartData data, _) => data.month,
                              yValueMapper: (BarChartData data, _) => data.amount
                          )
                        ]
                    )
                ),
              ),
            ),

        ],
      )),
    );
  }
}
