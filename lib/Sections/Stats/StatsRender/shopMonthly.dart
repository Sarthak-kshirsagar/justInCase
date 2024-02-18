import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'models.dart';

class MonthlyStoreRender extends StatefulWidget {
  const MonthlyStoreRender({super.key});

  @override
  State<MonthlyStoreRender> createState() => _MonthlyStoreRenderState();
}

class _MonthlyStoreRenderState extends State<MonthlyStoreRender> {

  //
  Future<List<BarChartData>> fetchCategorizeExpenseData(String userId) async {
    List<BarChartData> barChartDataList = [];

    try {
      // Query to get the CategorizeExpense document with the matching UID
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('CategorizeExpense')
          .where('userId', isEqualTo: userId)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Iterate through the documents (there should be only one for the given UID)
        querySnapshot.docs.forEach((DocumentSnapshot<Map<String, dynamic>> docSnapshot) {
          // Get the data from the document
          Map<String, dynamic> data = docSnapshot.data()!;

          // Access the monthlyExpenses and iterate through each category
          Map<String, dynamic> monthlyExpenses = data['monthlyCategory'] ?? {};
          monthlyExpenses.forEach((String category, dynamic amount) {
            // Add data to the list
            barChartDataList.add(BarChartData(category, amount.toDouble()));
          });
        });
      } else {
        print('No document found for user: $userId');
      }
    } catch (e) {
      print('Error fetching CategorizeExpense data: $e');
    }

    return barChartDataList;
  }

  List<BarChartData> l1 = [];
  void ini()async{
    List<BarChartData> l2 = await fetchCategorizeExpenseData("6scHAN7yriZuPxa3A7FhIaqtfRy1");
    setState(() {
      l1=l2;
    });
  }
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipBehavior =  TooltipBehavior(enable: true);
    ini();
    print("caled");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:Center(
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
                  "Categories Expenses",
                  style: TextStyle(
                    fontSize:25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
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
                        BarChartData("Food", 300),
                        BarChartData("Health", 400),
                        BarChartData("Fashion", 800),
                      ],
                      xValueMapper: (BarChartData data, _) => data.month,
                      yValueMapper: (BarChartData data, _) => data.amount,
                      name: 'Data',
                      // dataLabelSettings:DataLabelSettings(isVisible : true)
                    ),

                  ],

                  legend: Legend(isVisible: true, alignment: ChartAlignment.center),
                )
            )
          ],
        ),
      )),
    );
  }
}
