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
  String selectedMonth = 'January';
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipBehavior =
        TooltipBehavior(enable: true, activationMode: ActivationMode.singleTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
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
                      dataSource: [
                        // Bind data source
                        BarChartData('Food', 35),
                        BarChartData('Stationary', 28),
                        BarChartData('Movies', 34),
                        BarChartData('Games', 32),
                        BarChartData('Xerox', 40)
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
              // Bind data source
              BarChartData('Food', 35),
              BarChartData('Stationary', 28),
              BarChartData('Movies', 34),
              BarChartData('Games', 32),
              BarChartData('Xerox', 40)
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
        ],
      )),
    );
  }
}
