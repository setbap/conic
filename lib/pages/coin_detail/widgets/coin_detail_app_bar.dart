
import 'package:flutter/material.dart';

class CoinDetailAppBar extends StatefulWidget {
  final ScrollController controller;
  const CoinDetailAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _CoinDetailAppBarState createState() => _CoinDetailAppBarState();
}

class _CoinDetailAppBarState extends State<CoinDetailAppBar> {
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
                SizedBox(
                  width: 12,
                ),
                Text(
                  "BTC",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
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
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
