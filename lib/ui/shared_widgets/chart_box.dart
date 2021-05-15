import 'package:coingecko/coingecko.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';

class SliverChartBox extends StatefulWidget {
  final List<CoinChart>? chartDataArray;
  final double currentPrice;

  const SliverChartBox({
    Key? key,
    this.chartDataArray,
    required this.currentPrice,
  }) : super(key: key);

  @override
  _SliverChartBoxState createState() => _SliverChartBoxState();
}

class _SliverChartBoxState extends State<SliverChartBox> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          PriceChange(
            change: widget.chartDataArray![activeIndex].prices!.last.price -
                widget.chartDataArray![activeIndex].prices!.first.price,
            price: widget.currentPrice,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: (widget.chartDataArray?.first.prices?.length ?? 0) > 0
                    ? FLChartBox(
                        chartData: widget.chartDataArray,
                        activeIndex: activeIndex,
                      )
                    : Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  timeButton(
                    text: '24h',
                    currentTime: activeIndex == 0 ? '24h' : '',
                    onPress: () {
                      setState(() {
                        activeIndex = 0;
                      });
                    },
                  ),
                  timeButton(
                    text: '7d',
                    currentTime: activeIndex == 1 ? '7d' : '',
                    onPress: () {
                      setState(() {
                        activeIndex = 1;
                      });
                    },
                  ),
                  timeButton(
                    text: '30d',
                    currentTime: activeIndex == 2 ? '30d' : '',
                    onPress: () {
                      setState(() {
                        activeIndex = 2;
                      });
                    },
                  ),
                  timeButton(
                    text: '1yr',
                    currentTime: activeIndex == 3 ? '1yr' : '',
                    onPress: () {
                      setState(() {
                        activeIndex = 3;
                      });
                    },
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }

  Container timeButton({
    required String text,
    required VoidCallback onPress,
    required String currentTime,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: text == currentTime
              ? Theme.of(context).colorScheme.secondary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: text == currentTime
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
          )),
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 4,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: text == currentTime
                ? Theme.of(context).colorScheme.onBackground
                : Theme.of(context).colorScheme.secondaryVariant,
          ),
        ),
      ),
    );
  }
}

class SliverChartBoxLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: MyShimmer(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: BoxShimmer(height: 250, width: double.infinity, radius: 8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BoxShimmer(height: 24, width: 40, radius: 4),
                BoxShimmer(height: 24, width: 40, radius: 4),
                BoxShimmer(height: 24, width: 40, radius: 4),
                BoxShimmer(height: 24, width: 40, radius: 4),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget timeButton({
    required String text,
    required VoidCallback onPress,
    required String currentTime,
  }) {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: text == currentTime
              ? Theme.of(context).colorScheme.secondary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextButton(
          onPressed: onPress,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: text == currentTime
                  ? Theme.of(context).cardColor
                  : Theme.of(context).dividerColor,
            ),
          ),
        ),
      ),
    );
  }
}
