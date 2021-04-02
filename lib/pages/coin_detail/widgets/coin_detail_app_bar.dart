import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CoinDetailAppBar extends StatelessWidget {
  final ScrollController controller;

  const CoinDetailAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      loadingWidget: CoinDetailAppBarLoading(),
      dataWidget: CoinDetailAppBarData(
        controller: controller,
      ),
      loading: true,
    );
  }
}

class CoinDetailAppBarData extends StatefulWidget {
  final ScrollController controller;
  const CoinDetailAppBarData({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _CoinDetailAppBarDataState createState() => _CoinDetailAppBarDataState();
}

class _CoinDetailAppBarDataState extends State<CoinDetailAppBarData> {
  double textOpacity = 0;

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final offset = widget.controller.offset;
      if (offset > 0 && offset < 70) {
        setState(() {
          textOpacity = (offset.clamp(30, 70) - 30) / 40;
        });
      } else if (offset < 0 && textOpacity < 0.01) {
        //when scroll so fast
        setState(() {
          textOpacity = 0;
        });
      } else if (offset > 70 && textOpacity < 0.98) {
        //when scroll so fast
        setState(() {
          textOpacity = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: BackButton(),
      pinned: true,
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.star_outline))],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: textOpacity,
            child: Row(
              children: [
                FittedBox(
                  child: Text(
                    "BTC",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.orange,
          ),
          Opacity(
            opacity: textOpacity,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Text(
                  "\$${0.0023}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CoinDetailAppBarLoading extends StatelessWidget {
  const CoinDetailAppBarLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: BackButton(),
      pinned: true,
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.star_outline))],
      title: Shimmer.fromColors(
        highlightColor: shimmerHighlightColor,
        baseColor: shimmerBaseColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BoxShimmer(height: 20, width: 40, radius: 4),
            SizedBox(
              width: 8,
            ),
            CircleShimmer(radius: 32),
            SizedBox(
              width: 8,
            ),
            BoxShimmer(height: 20, width: 40, radius: 4),
          ],
        ),
      ),
    );
  }
}
