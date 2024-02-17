import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class StatisticsPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  StatisticsPage({Key? key}) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}
class _StatisticsPageState extends State<StatisticsPage> {
  late List<_SalesData> _chartData;

  @override
  void initState() {
    _chartData = <_SalesData>[
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Pie Chart Demo'),
      ),
      body: Column(
        children: [Row(
          children: [
           ]
        ),
          Expanded(
            child: Container(
              height: 400,
              width: 400,

              child: SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<_SalesData, String>(
                    dataSource: _chartData,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}