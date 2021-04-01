import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class CoinListItemData extends StatelessWidget {
  final String imageSrc;
  final String name;
  final String chartSrc;
  final double price;
  final int rank;
  final String id;
  final double change;
  final double marketCap;

  const CoinListItemData({
    Key? key,
    required this.imageSrc,
    required this.name,
    required this.chartSrc,
    required this.price,
    required this.rank,
    required this.id,
    required this.change,
    required this.marketCap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              radius: 20,
              child: Image.network(
                imageSrc,
                errorBuilder: (context, error, stackTrace) => Placeholder(),
              ),
            ),
          ),
          Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                      Image.network(
                        chartSrc,
                        height: 24,
                        color: Colors.green,
                        errorBuilder: (context, error, stackTrace) => Container(
                          child: Text(
                            "error in connection",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(),
                      Text(
                        "$price\$",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              '$rank',
                              style: TextStyle(fontSize: 10),
                            ),
                            decoration: BoxDecoration(
                              color: DarkPrimaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 10,
                            ),
                            margin: EdgeInsets.only(
                              right: 6,
                            ),
                          ),
                          Text(
                            id,
                            style:
                            TextStyle(fontSize: 12, color: DarkTextForeground),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          ChangeShow(change: change)
                        ],
                      ),
                      Text(
                        'MCap $marketCap ',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: 12, color: DarkTextForeground),
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
                color: Colors.yellow,
                size: 16,
              ),
            ),
          )
        ],
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
      child: Shimmer.fromColors(
        highlightColor: shimmerHighlightColor,
        baseColor: shimmerBaseColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 12),
              child: CircleShimmer(radius:40),
            ),
            Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        BoxShimmer(height: 20, width: 24, radius: 4),
                        BoxShimmer(height: 20, width: 64, radius: 4),
                        SizedBox(width: 8,),
                        BoxShimmer(height: 20, width: 24, radius: 4),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(
                      height: 12
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            BoxShimmer(height: 20, width: 32, radius: 4),
                            SizedBox(width: 8,),
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
