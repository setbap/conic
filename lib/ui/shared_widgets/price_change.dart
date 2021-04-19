import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/colors.dart';
import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';
import 'package:shimmer/shimmer.dart';

class PriceChange extends StatelessWidget {
  final double price;
  final double change;

  const PriceChange({
    required this.price,
    required this.change,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay(length: 8);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Balance",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: DarkTextForeground,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${numberDisplay(price)} \$",
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
                ChangeShow(
                  change: change,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PriceChangeLoading extends StatelessWidget {
  const PriceChangeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Shimmer.fromColors(
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
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
