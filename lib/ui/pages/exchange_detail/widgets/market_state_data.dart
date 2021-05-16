import 'package:conic/ui/pages/coin_detail/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class ExchangeInfoShow extends StatelessWidget {
  final String trustScore;
  final String rank;
  final bool isCentralized;

  final double btcVolume;
  final String countery;
  final String yearEstablished;

  const ExchangeInfoShow({
    Key? key,
    required this.btcVolume,
    required this.countery,
    required this.isCentralized,
    required this.rank,
    required this.yearEstablished,
    required this.trustScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay(length: 6);

    return Container(
      height: 120,
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
                    dataKey: "Btc Volume",
                    dataValue: numberDisplay(btcVolume),
                    ending: " btc",
                  ),
                  KeyValueDataGeneric(
                    dataKey: "countery    ",
                    dataValueWidget: Container(
                      child: Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            countery,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  KeyValueData(
                    dataKey: "Centralized",
                    dataValue: isCentralized.toString(),
                    ending: "",
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
              margin: EdgeInsets.only(right: 8),
            ),
            Expanded(
              child: Column(
                children: [
                  KeyValueData(
                    dataKey: "rank",
                    dataValue: rank,
                    ending: "",
                  ),
                  KeyValueData(
                    dataKey: "year established",
                    dataValue: yearEstablished,
                    ending: "",
                  ),
                  KeyValueData(
                    dataKey: "trust Score",
                    dataValue: trustScore,
                    ending: "",
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
