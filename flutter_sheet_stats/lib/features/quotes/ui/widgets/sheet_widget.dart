import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import '../../../../models/sheet_model.dart';

class SheetWidget extends StatelessWidget {
  SheetWidget(
      {Key? key,
      required this.model,
      required this.oldModel,
      required this.onPressed})
      : super(key: key);

  final Sheet model;
  final Sheet oldModel;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Sheet', model.rows!.length.toDouble()),
      ChartData('OldSheet', oldModel.rows!.length.toDouble()),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    model.name.toString() + ' data:',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'New rows: ' + model.rows!.length.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'old rows: ' + oldModel.rows!.length.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                SfCircularChart(series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                  )
                ]),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Refresh'),
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
