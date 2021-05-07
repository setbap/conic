import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class CoinListItemData extends StatelessWidget {
  final String imageSrc;
  final String name;
  final List<double> chartData;
  final double price;
  final int? rank;
  final String id;
  final double? change;
  final double? marketCap;
  final VoidCallback onPressed;

  const CoinListItemData({
    Key? key,
    required this.imageSrc,
    required this.name,
    required this.chartData,
    required this.price,
    required this.rank,
    required this.id,
    this.change,
    this.marketCap,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(length: 8);

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: CircleAvatar(
                radius: 16,
                child: Image.network(
                  imageSrc,
                  errorBuilder: (context, error, stackTrace) {
                    return Placeholder();
                  },
                ),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: MyLineChart(
                          chartData: chartData
                              .sublist((chartData.length * 6 ~/ 7))
                              .toList(),
                          height: 24,
                          width: 36,
                        ),
                      ),
                    ),
                    SizedBox(),
                    Container(
                      width: 60,
                      child: Text(
                        "${display(price)}\$",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                            fontSize: 10),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24,
                          child: Text(
                            '$rank',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 9,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          margin: EdgeInsets.only(
                            right: 6,
                          ),
                        ),
                        Container(
                          width: 32,
                          child: Text(
                            id,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        ChangeShow(change: change)
                      ],
                    ),
                    Text(
                      'MCap ${display(marketCap)} ',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            )),
            Container(
              child: CupertinoButton(
                padding: const EdgeInsets.all(2),
                onPressed: () {},
                child: Icon(
                  Icons.star_border_outlined,
                  size: 12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CoinListItemLoading extends StatelessWidget {
  const CoinListItemLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: MyShimmer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: CircleShimmer(radius: 40),
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    BoxShimmer(height: 20, width: 24, radius: 4),
                    BoxShimmer(height: 20, width: 64, radius: 4),
                    SizedBox(
                      width: 8,
                    ),
                    BoxShimmer(height: 20, width: 24, radius: 4),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Row(
                      children: [
                        BoxShimmer(height: 20, width: 32, radius: 4),
                        SizedBox(
                          width: 8,
                        ),
                        BoxShimmer(height: 20, width: 56, radius: 4),
                      ],
                    ),
                    BoxShimmer(height: 20, width: 40, radius: 4),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            )),
            Container(
              child: CupertinoButton(
                padding: const EdgeInsets.all(2),
                onPressed: () {},
                child: Icon(
                  Icons.star_border_outlined,
                  color: Colors.yellow,
                  size: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
