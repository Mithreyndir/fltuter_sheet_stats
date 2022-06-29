import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../models/sheet_model.dart';
import 'package:json_diff/json_diff.dart';

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
    // Check if sheet has changed
    print(oldModel == model);

    // Create Json differ object
    final differ = JsonDiffer.fromJson(model.toJson(), oldModel.toJson());
    DiffNode diff = differ.diff();
    String data = diff.node.values.toString();

    // Print difference between two sheets
    print(data);

    // Create data for pie chart
    int added = data.split('Added').length;
    int removed = data.split('Removed').length;
    int edited = data.split('+ "').length;
    print("--------");

    final List<ChartData> chartData = [
      ChartData('added', added.toDouble()),
      ChartData('removed', removed.toDouble()),
      ChartData('edited', edited.toDouble()),
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
                SfCircularChart(series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Added: ' + added.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Deleted: ' + removed.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    'Changed: ' + edited.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  child: const Text('Refresh'),
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                ),
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
