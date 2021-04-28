import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';
import 'package:shimmer/shimmer.dart';

class PortfolioTableDataRow extends StatelessWidget {
  final bool isLoading;
  final String imageSrc;
  final String name;
  final String symbol;
  final String id;
  final double? price;
  final double coinCount;
  final double? change;
  final VoidCallback onPress;

  const PortfolioTableDataRow({
    Key? key,
    required this.name,
    required this.imageSrc,
    required this.id,
    required this.symbol,
    this.price,
    required this.coinCount,
    this.change,
    required this.onPress,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay(length: 7);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPress,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      child: CircleAvatar(
                        child: Image.network(
                          imageSrc,
                          height: 32,
                          width: 32,
                          errorBuilder: (_, __, ___) =>
                              Container(color: Colors.yellow),
                        ),
                      ),
                      height: 48,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          id,
                          style: TextStyle(
                            fontSize: 12,
                            color: DarkTextForeground,
                          ),
                          textAlign: TextAlign.start,
                        )
                      ],
                    )
                  ],
                ),
                flex: 2,
              ),
              LoadingShimmer(
                loadingWidget: Shimmer.fromColors(
                  baseColor: shimmerBaseColor,
                  highlightColor: shimmerHighlightColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BoxShimmer(height: 16, width: 44, radius: 4),
                      SizedBox(
                        height: 4,
                      ),
                      BoxShimmer(height: 16, width: 44, radius: 4),
                    ],
                  ),
                ),
                loading: isLoading,
                error: false,
                dataWidget: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        numberDisplay(price) + " \$",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ChangeShow(
                        change: change,
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      LoadingShimmer(
                        error: false,
                        loading: isLoading,
                        loadingWidget: Shimmer.fromColors(
                          baseColor: shimmerBaseColor,
                          highlightColor: shimmerHighlightColor,
                          child: BoxShimmer(height: 16, width: 44, radius: 4),
                        ),
                        dataWidget: Text(
                          numberDisplay(isLoading ? 0 : price! * coinCount),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Text(
                        '${numberDisplay(coinCount)} $symbol',
                        style: TextStyle(
                          fontSize: 12,
                          color: DarkTextForeground,
                        ),
                        textAlign: TextAlign.end,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class PortfollioTableHeader extends StatelessWidget {
  const PortfollioTableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                "Asset",
                textAlign: TextAlign.left,
              ),
            ),
            flex: 2,
          ),
          Expanded(
              child: Text(
            "Price",
            textAlign: TextAlign.center,
          )),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(right: 8),
            child: Text(
              "Holdings",
              textAlign: TextAlign.end,
            ),
          )),
        ],
      ),
    );
  }
}
