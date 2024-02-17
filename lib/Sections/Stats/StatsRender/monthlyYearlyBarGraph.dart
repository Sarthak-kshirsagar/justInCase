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
    _tooltipBehavior =  TooltipBehavior(

        enable: true,activationMode: ActivationMode.singleTap);
  }
  Color monthlyExp = Colors.grey;
  Color yearlyExp = Colors.grey;
  bool showMonthlyGraph=true;
  double registerContainerHeight = 350;
  bool isLoading = false;
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                            dataSource: data,
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
                              dataSource: yearlyData,
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
