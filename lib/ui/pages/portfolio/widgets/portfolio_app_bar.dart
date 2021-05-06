import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';
import 'package:shimmer/shimmer.dart';

class PortfolioAppBar extends StatefulWidget {
  final ScrollController controller;
  final double price;
  final VoidCallback onPress;
  const PortfolioAppBar({
    Key? key,
    required this.controller,
    required this.price,
    required this.onPress,
  }) : super(key: key);

  @override
  _PortfolioAppBarState createState() => _PortfolioAppBarState();
}

class _PortfolioAppBarState extends State<PortfolioAppBar> {
  double textOpacity = 0;
  bool isDisposed = false;
  dynamic numberDisplay;
  @override
  void initState() {
    super.initState();

    numberDisplay = createDisplay(length: 8);
    widget.controller.addListener(() {
      if (!isDisposed) {
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
      }
    });
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: Opacity(
        opacity: textOpacity,
        child: Text(
          "\$ ${numberDisplay(widget.price)}",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      actions: [
        CupertinoButton(
          child: Icon(
            Icons.add_circle_outlined,
            color: Theme.of(context).cardColor,
          ),
          onPressed: widget.onPress,
        )
      ],
    );
  }
}

class PortfolioAppBarLoading extends StatelessWidget {
  const PortfolioAppBarLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Theme.of(context).backgroundColor,
      title: Shimmer.fromColors(
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
        child: BoxShimmer(width: 48, height: 20, radius: 4),
      ),
      actions: [
        CupertinoButton(
          child: Icon(
            Icons.add_circle_outlined,
            color: Theme.of(context).cardColor,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
