import 'package:conic/pages/coin_detail/widgets/widgets.dart';
import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';

class MarketState extends StatelessWidget {
  final double mktCap;
  final double circSupply;
  final double totSupply;

  final double volIn24h;
  final double maxSupply;
  final double roi;
  final double rank;
  const MarketState({
    Key? key,
    required this.mktCap,
    required this.circSupply,
    required this.totSupply,
    required this.volIn24h,
    required this.maxSupply,
    required this.roi,
    required this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
                    dataValue: mktCap,
                  ),
                  KeyValueData(
                    dataKey: "Circ Supply",
                    dataValue: circSupply,
                  ),
                  KeyValueData(
                    dataKey: "TOT Supply",
                    dataValue: totSupply,
                  ),
                  KeyValueData(
                    dataKey: "Rank",
                    dataValue: rank,
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
                    dataKey: "2dh Vol",
                    dataValue: volIn24h,
                  ),
                  KeyValueData(
                    dataKey: "Max Supply",
                    dataValue:maxSupply,
                  ),
                  KeyValueDataGeneric(
                    dataKey: "ROi",
                    dataValueWidget: ChangeShow(
                      change: roi,
                    ),
                  ),
                  Container(
                    height: 48,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
