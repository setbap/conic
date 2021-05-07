import 'dart:ui';

import 'package:coingecko/coingecko.dart';
import 'package:conic/ui/pages/coin_detail/widgets/widgets.dart';

import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/link.dart';

class CoinAbout extends StatelessWidget {
  final CoinDecription? coinDecription;
  const CoinAbout({Key? key, this.coinDecription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (coinDecription == null) {
      return SliverPadding(
        padding: EdgeInsets.all(8),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.all(1),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About ${coinDecription!.name}",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 12,
            ),
            ExpansionTile(
              title: Text("What is ${coinDecription!.name}"),
              leading: Icon(Icons.add_circle_outlined),
              childrenPadding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              expandedAlignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${coinDecription!.description?.en}",
                  ),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: (coinDecription?.categories ?? [])
                      .map((e) => CustomChip(text: e))
                      .toList(),
                ),
              ],
            ),
            if (coinDecription?.links?.homepage != null)
              ExpansionTile(
                title: Text("Home Page"),
                leading: Icon(Icons.add_circle_outlined),
                childrenPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 1,
                ),
                expandedAlignment: Alignment.centerLeft,
                children: coinDecription!.links!.homepage!.map((e) {
                  if (e == "") return Container();
                  return Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    child: MyLink(
                      path: e,
                    ),
                  );
                }).toList(),
              ),
            if (coinDecription?.links?.blockchainSite != null)
              ExpansionTile(
                title: Text("Blockchain Sites"),
                leading: Icon(Icons.add_circle_outlined),
                childrenPadding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                expandedAlignment: Alignment.centerLeft,
                children: coinDecription!.links!.blockchainSite!.map((e) {
                  if (e == "") return Container();
                  return Container(
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    child: MyLink(path: e),
                  );
                }).toList(),
              ),
            if (coinDecription?.links?.twitterScreenName != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Twitter")),
                    MyLink(
                      path:
                          'https://twitter.com/${coinDecription!.links!.twitterScreenName}',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MyLink extends StatelessWidget {
  final String path;

  const MyLink({Key? key, required this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Link(
      uri: Uri.parse(path),
      target: LinkTarget.self,
      builder: (context, followLink) => TextButton(
        onPressed: followLink,
        child: Text(
          path,
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 14,
            color: Colors.blue.shade300,
          ),
          textAlign: TextAlign.start,
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
            .map((_) => MyShimmer(
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
                        color: Theme.of(context).accentColor,
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
