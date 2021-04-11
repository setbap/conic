import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoxTextTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onPressSeeAll;
  final String? subTitle;
  const BoxTextTitle({
    required this.title,
    this.onPressSeeAll,
    this.subTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
                onPressSeeAll != null
                    ? CupertinoButton(
                        padding: EdgeInsets.all(0),
                        minSize: 32,
                        onPressed: onPressSeeAll,
                        child: Text(
                          "See All",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.blue,
                                wordSpacing: 2,
                              ),
                        ),
                      )
                    : Container(),
              ],
            ),
            subTitle != null
                ? Text(
                    subTitle!,
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.start,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
