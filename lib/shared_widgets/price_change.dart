import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/colors.dart';
import 'package:flutter/material.dart';

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
                  "${price} \$",
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
