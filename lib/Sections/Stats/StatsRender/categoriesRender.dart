import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projecthack/Sections/Stats/StatsRender/models.dart/';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoriesRender extends StatefulWidget {
  const CategoriesRender({super.key});

  @override
  State<CategoriesRender> createState() => _CategoriesRenderState();
}

class _CategoriesRenderState extends State<CategoriesRender> {
  List<BarChartData> data = [
    BarChartData(
      "Jan",
      2500,
    ),
    BarChartData(
      "Feb",
      3500,
    ),
    BarChartData(
      "March",
      4500,
    ),
    BarChartData(
      "Apr",
      3500,
    ),
  ];
  List<BarChartData> yearlyData = [
    BarChartData(
      "2022",2500,
    ),
    BarChartData(
      "2023",3500,
    ),

  ];

  late TooltipBehavior _tooltipBehavior;
  Color monthlyExp = Colors.purpleAccent;
  Color yearlyExp = Colors.grey;
  bool showMonthlyGraph=true;
  double registerContainerHeight = 350;
  bool isLoading = false;






  Future<List<BarChartData>> fetchShopWiseDataFromFirestore() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        // Fetch data from Firestore
        QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
            .collection('ShopWiseExpense')  // Make sure the collection name is correct
            .where('userId', isEqualTo: userId)
            .get();

        List<BarChartData> data = [];

        // Iterate through the documents and create BarChartData objects
        querySnapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> document) {
          // Accessing the data in the document
          Map<String, dynamic> shopData = document.data() ?? {};

          // Extract shopName and value
          shopData.forEach((String shopName, dynamic value) {
            if (value != null && value is num) {
              data.add(BarChartData(shopName, value.toDouble()));
            } else {
              print('Invalid value for shopName: $shopName, value: $value');
            }
          });
        });

        print('Final Data: $data');
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
    List<BarChartData> l1 = await fetchShopWiseDataFromFirestore();
    setState(() {
      fetchedData = l1;
    });
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
  String selectedMonth = "February";
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
    _tooltipBehavior =
        TooltipBehavior(enable: true, activationMode: ActivationMode.singleTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
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
                "Monthly Expenses",
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
            child: DropdownButton<String>(
              value: selectedMonth,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMonth = newValue!;
                });
              },
              items: [
                'January',
                'February',
                'March',
                'April',
                'May',
                'June',
                'July',
                'August',
                'September',
                'October',
                'November',
                'December',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 20),
          if(showMonthlyGraph==true)
          Text(
            'Selected Month: $selectedMonth',
            style: TextStyle(fontSize: 18),
          ),
          if(showMonthlyGraph==true)
            Container(
                child: SfCircularChart(
                  // Enables the tooltip for all the series in chart
                  tooltipBehavior: _tooltipBehavior,





                  series: <CircularSeries>[
                    // Initialize line series
                    PieSeries<BarChartData, String>(

                      // Enables the tooltip for individual series
                      enableTooltip: true,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          labelAlignment: ChartDataLabelAlignment.bottom,
                          labelIntersectAction: LabelIntersectAction.shift,
                          labelPosition: ChartDataLabelPosition.outside,
                          connectorLineSettings: ConnectorLineSettings(
                              type: ConnectorType.curve, length: '25%')

                      ),
                      dataSource:[
    BarChartData("Roshni", 300),
    BarChartData("Clinic", 400),
    BarChartData("Trends", 800),
    ],
                      xValueMapper: (BarChartData data, _) => data.month,
                      yValueMapper: (BarChartData data, _) => data.amount,
                      name: 'Data',
                      // dataLabelSettings:DataLabelSettings(isVisible : true)
                    ),

                  ],

                  legend: Legend(isVisible: true, alignment: ChartAlignment.center),
                )
            ),
if(showMonthlyGraph==false)
  Container(
      child: SfCircularChart(
        // Enables the tooltip for all the series in chart
        tooltipBehavior: _tooltipBehavior,





        series: <CircularSeries>[
          // Initialize line series
          PieSeries<BarChartData, String>(

            // Enables the tooltip for individual series
            enableTooltip: true,
            dataLabelSettings: DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.bottom,
                labelIntersectAction: LabelIntersectAction.shift,
                labelPosition: ChartDataLabelPosition.outside,
                connectorLineSettings: ConnectorLineSettings(
                    type: ConnectorType.curve, length: '25%')

            ),
            dataSource: [
              BarChartData("Roshni", 300),
              BarChartData("Clinic", 400),
              BarChartData("Trends", 800),
            ],
            // dataSource: [
            //   // Bind data source
            //   BarChartData('Food', 35),
            //   BarChartData('Stationary', 28),
            //   BarChartData('Movies', 34),
            //   BarChartData('Games', 32),
            //   BarChartData('Xerox', 40)
            // ],
            xValueMapper: (BarChartData data, _) => data.month,
            yValueMapper: (BarChartData data, _) => data.amount,
            name: 'Data',
            // dataLabelSettings:DataLabelSettings(isVisible : true)
          ),

        ],

        legend: Legend(isVisible: true, alignment: ChartAlignment.center),
      )
  ),
        ],
      )),
    );
  }
}
