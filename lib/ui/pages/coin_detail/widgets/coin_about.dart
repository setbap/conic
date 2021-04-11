import 'package:conic/ui/pages/coin_detail/widgets/widgets.dart';
import 'package:conic/utils/colors.dart';
import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CoinAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      loadingWidget: CoinAboutLoading(),
      dataWidget: CoinAboutData(),
      loading: true,
      error: false,
      errorWidget: Container(),
    );
  }
}

class CoinAboutData extends StatelessWidget {
  const CoinAboutData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(8),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Coin",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 12,
            ),
            ExpansionTile(
              title: Text("What is asdas"),
              leading: Icon(Icons.add_circle_outlined),
              childrenPadding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              expandedAlignment: Alignment.centerLeft,
              children: [
                Text(
                    "lorem adha siud aa oasd pASYD asdpYASPD  ya sdpAYS DPUCL HCIU DH"),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    CustomChip(text: "test"),
                    CustomChip(text: "asda"),
                    CustomChip(text: "test"),
                  ],
                ),
              ],
            ),
            Divider(),
            ListTile(
              title: Text("What is VECHAIN"),
              leading: Icon(Icons.add_circle_outlined),
            ),
            Divider(),
            ListTile(
              title: Text("Reddit"),
              leading: Icon(Icons.add_circle_outlined),
            ),
            Divider(),
            ListTile(
              title: Text("Source"),
              leading: Icon(Icons.add_circle_outlined),
            ),
            Divider(),
            ListTile(
              title: Text("Twitter"),
              leading: Icon(Icons.add_circle_outlined),
            ),
            Divider(),
            ListTile(
              title: Text("Chat"),
              leading: Icon(Icons.add_circle_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

class CoinAboutLoading extends StatelessWidget {
  const CoinAboutLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [1, 2, 3, 4, 5, 6]
            .map((_) => Shimmer.fromColors(
                  highlightColor: shimmerHighlightColor,
                  baseColor: shimmerBaseColor,
                  child: Column(
                    children: [
                      ListTile(
                        title: BoxShimmer(height: 28, width: 50, radius: 4),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          size: 28,
                        ),
                        leading: CircleShimmer(radius: 36),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Divider(
                        height: 2,
                        color: DarkForeground,
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
