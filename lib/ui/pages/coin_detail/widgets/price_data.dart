import 'package:conic/ui/pages/coin_detail/widgets/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class PriceData extends StatelessWidget {
  final double? ath;
  final double? high;
  final double? changePercentage;
  final double? atl;
  final double? low;
  final double? change;

  const PriceData({
    Key? key,
    this.ath,
    this.high,
    this.changePercentage,
    this.atl,
    this.low,
    this.change,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay(length: 7);
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
                    dataKey: "ATH",
                    dataValue: numberDisplay(ath),
                  ),
                  KeyValueData(
                    dataKey: "High",
                    dataValue: numberDisplay(high),
                  ),
                  KeyValueDataGeneric(
                    dataKey: "Chnage%",
                    dataValueWidget: Text(
                      " ${numberDisplay(changePercentage)} \%",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              color: Theme.of(context).accentColor,
              width: 2,
              margin: EdgeInsets.only(right: 8),
            ),
            Expanded(
              child: Column(
                children: [
                  KeyValueData(
                    dataKey: "ATL",
                    dataValue: numberDisplay(atl),
                  ),
                  KeyValueData(
                    dataKey: "Low",
                    dataValue: numberDisplay(low),
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

class PriceDataLoading extends StatelessWidget {
  const PriceDataLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(8.0),
      child: MyShimmer(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    KeyValueDataLoading(),
                    KeyValueDataLoading(),
                    KeyValueDataLoading(),
                  ],
                ),
              ),
              Container(
                height: 120,
                color: Theme.of(context).accentColor,
                width: 2,
                margin: EdgeInsets.only(right: 8),
              ),
              Expanded(
                child: Column(
                  children: [
                    KeyValueDataLoading(),
                    KeyValueDataLoading(),
                    KeyValueDataLoading(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
