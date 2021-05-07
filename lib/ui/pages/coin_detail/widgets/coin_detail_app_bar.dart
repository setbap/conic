import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class CoinDetailAppBar extends StatefulWidget {
  final ScrollController controller;
  final String symbol;
  final double price;
  final String imageSrc;
  const CoinDetailAppBar({
    Key? key,
    required this.price,
    required this.symbol,
    required this.imageSrc,
    required this.controller,
  }) : super(key: key);

  @override
  _CoinDetailAppBarState createState() => _CoinDetailAppBarState();
}

class _CoinDetailAppBarState extends State<CoinDetailAppBar> {
  double textOpacity = 0;
  bool isPageClosed = false;
  var numberDisply = createDisplay(length: 8);
  @override
  void dispose() {
    isPageClosed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final offset = widget.controller.offset;
      if (!isPageClosed) {
        if (offset > 0 && offset < 70) {
          setState(() {
            textOpacity = (offset.clamp(30, 70) - 30) / 40;
          });
        } else if (offset < 0 && textOpacity < 0.01) {
          //when scroll so fast
          setState(() {
            textOpacity = 0;
          });
        } else if (offset > 70 && textOpacity < 0.98) {}
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
                    widget.symbol,
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontWeight: FontWeight.w500),
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
            child: Image.network(
              widget.imageSrc,
            ),
            radius: 16,
          ),
          Opacity(
            opacity: textOpacity,
            child: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                Text(
                  "\$${numberDisply(widget.price)}",
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
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
      title: MyShimmer(
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
