import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'models.dart';

class MonthlyStoreRender extends StatefulWidget {
  const MonthlyStoreRender({super.key});

  @override
  State<MonthlyStoreRender> createState() => _MonthlyStoreRenderState();
}

class _MonthlyStoreRenderState extends State<MonthlyStoreRender> {


  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipBehavior =  TooltipBehavior(enable: true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                        BarChartData('Roshni', 35),
                        BarChartData('ShindeShahi', 28),
                        BarChartData('Jagdamb', 34),
                        BarChartData('Tai', 32),
                        BarChartData('Morya', 40)
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
