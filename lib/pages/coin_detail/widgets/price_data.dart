import 'package:conic/pages/coin_detail/widgets/widgets.dart';
import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';

class PriceData extends StatelessWidget {
  final double open;
  final double high;
  final double average;
  final double close;
  final double low;
  final double change;

  const PriceData({
    Key? key,
    required this.open,
    required this.high,
    required this.average,
    required this.close,
    required this.low,
    required this.change,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  KeyValueData(
                    dataKey: "Open",
                    dataValue: open,
                  ),
                  KeyValueData(
                    dataKey: "High",
                    dataValue: high,
                  ),
                  KeyValueData(
                    dataKey: "Average",
                    dataValue: average,
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              color: DarkForeground,
              width: 2,
              margin: EdgeInsets.only(right: 8),
            ),
            Expanded(
              child: Column(
                children: [
                  KeyValueData(
                    dataKey: "Close",
                    dataValue: close,
                  ),
                  KeyValueData(
                    dataKey: "Low",
                    dataValue: low,
                  ),
                  KeyValueDataGeneric(
                    dataKey: "Change",
                    dataValueWidget: ChangeShow(
                      change: change,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
