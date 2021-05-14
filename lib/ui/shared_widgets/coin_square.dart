import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class CoinSquare extends StatelessWidget {
  final String coinName;
  final double price;
  final double change;
  final String imgSrc;
  final VoidCallback onPress;
  const CoinSquare({
    Key? key,
    required this.coinName,
    required this.change,
    required this.imgSrc,
    required this.price,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay(length: 8);

    return Container(
      width: 134,
      height: 134,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: CupertinoButton(
        onPressed: onPress,
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Image.network(
                  imgSrc,
                  width: 36,
                  height: 36,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      coinName,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Theme.of(context).cardColor),
                    ),
                    Text(
                      numberDisplay(price),
                      // TODO : text color
                      style: Theme.of(context).textTheme.caption!.copyWith(),
                    ),
                  ],
                ),
              ),
              ChangeShow(change: change)
            ],
          ),
        ),
      ),
    );
  }
}

class CoinSquareLoading extends StatelessWidget {
  const CoinSquareLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      height: 134,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: MyShimmer(
        child: Container(
          padding: EdgeInsets.zero,
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: CircleShimmer(
                    radius: 24,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxShimmer(
                        width: 36.0,
                        height: 20.0,
                        radius: 4,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      BoxShimmer(
                        width: 36.0,
                        height: 20.0,
                        radius: 4,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                BoxShimmer(
                  width: 48.0,
                  height: 24.0,
                  radius: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
