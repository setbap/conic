import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinSquare extends StatelessWidget {
  final String coinName;
  final double price;
  final double change;
  final VoidCallback onPress;
  const CoinSquare({
    Key? key,
    required this.coinName,
    required this.change,
    required this.price,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      height: 134,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: DarkForeground,
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
                child: Icon(
                  Icons.monetization_on,
                  color: Colors.yellowAccent,
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
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      price.toStringAsFixed(4),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: DarkTextForeground),
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
