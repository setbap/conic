import 'package:conic/ui/shared_widgets/shared_widgets.dart';

import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class PriceChange extends StatelessWidget {
  final String title;
  final double price;
  final double? change;
  final String? priceEnding;
  final String? changeEnding;

  const PriceChange({
    required this.price,
    required this.title,
    this.priceEnding,
    this.changeEnding,
    this.change,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay(length: 8);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${numberDisplay(price)} ${priceEnding ?? "\$"}",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
              ChangeShow(
                change: change,
                ending: changeEnding ?? "%",
                fontSize: 14,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class PriceChangeLoading extends StatelessWidget {
  const PriceChangeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: MyShimmer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxShimmer(height: 20, width: 48, radius: 4),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoxShimmer(height: 24, width: 48, radius: 4),
                  BoxShimmer(height: 20, width: 48, radius: 4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
