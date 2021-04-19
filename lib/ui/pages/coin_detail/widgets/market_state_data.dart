import 'package:conic/ui/pages/coin_detail/widgets/widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class MarketState extends StatelessWidget {
  final double? mktCap;
  final double? sentimentVotesDownPercentage;

  final double? coingeckoScore;
  final double? sentimentVotesUpPercentage;

  final int? rank;
  const MarketState({
    Key? key,
    this.mktCap,
    this.sentimentVotesDownPercentage,
    this.coingeckoScore,
    this.sentimentVotesUpPercentage,
    this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay(length: 6);

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
                    dataKey: "Mkt Cap",
                    dataValue: numberDisplay(mktCap),
                  ),
                  KeyValueDataGeneric(
                      dataKey: "Up vote %",
                      dataValueWidget: Text(
                        " ${numberDisplay(sentimentVotesUpPercentage)} \%",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      )),
                  KeyValueDataGeneric(
                    dataKey: "Rank",
                    dataValueWidget: Text(
                      " ${numberDisplay(rank)} ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
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
                    dataKey: "CG Score",
                    dataValue: numberDisplay(coingeckoScore),
                  ),
                  KeyValueDataGeneric(
                      dataKey: "Down vote",
                      dataValueWidget: Text(
                        " ${numberDisplay(sentimentVotesDownPercentage)} \%",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      )),
                  KeyValueDataGeneric(
                    dataKey: "",
                    dataValueWidget: Text(""),
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
