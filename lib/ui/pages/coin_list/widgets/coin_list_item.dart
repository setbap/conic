import 'package:conic/manager/manager.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_display/number_display.dart';

class CoinListItemData extends StatelessWidget {
  final String imageSrc;
  final String name;
  final List<double> chartData;
  final double price;
  final int? rank;
  final String id;
  final String symbol;
  final double? change;
  final double? marketCap;
  final VoidCallback onPressed;
  final VoidCallback? onFavPressed;

  const CoinListItemData({
    Key? key,
    this.onFavPressed,
    required this.imageSrc,
    required this.name,
    required this.chartData,
    required this.price,
    required this.rank,
    required this.id,
    required this.symbol,
    this.change,
    this.marketCap,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(length: 8);

    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
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
                        style: Theme.of(context).textTheme.bodyText1,
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
                      width: 70,
                      child: Text(
                        "${display(price)}\$",
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
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
                          width: 20,
                          child: Text(
                            '$rank',
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    ),
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                          ),
                          margin: EdgeInsets.only(
                            right: 3,
                          ),
                        ),
                        Container(
                          width: 32,
                          child: Text(
                            symbol,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        ChangeShow(
                          change: change,
                          ending: "%",
                          lenCount: 5,
                        )
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
                child: CoinStar(id: id, onFavPressed: onFavPressed),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CoinStar extends StatefulWidget {
  final String id;
  final VoidCallback? onFavPressed;
  const CoinStar({
    Key? key,
    required this.id,
    this.onFavPressed,
  }) : super(key: key);

  @override
  _CoinStarState createState() => _CoinStarState();
}

class _CoinStarState extends State<CoinStar> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (widget.onFavPressed != null) {
            widget.onFavPressed!();
          }

          if (context.read<FivManager>().toggleFiv(id: widget.id)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Coin Added to Fav List",
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Coin deleted from Fav List",
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
            );
          }
          setState(() {});
        },
        iconSize: 16,
        icon: Icon(
          context.read<FivManager>().isFiv(id: widget.id)
              ? Icons.star_outlined
              : Icons.star_outline,
        ));
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
