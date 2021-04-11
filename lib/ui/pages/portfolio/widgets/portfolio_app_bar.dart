import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PortfolioAppBar extends StatelessWidget {
  final ScrollController controller;

  const PortfolioAppBar({Key? key, required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      loadingWidget: PortfolioAppBarLoading(),
      dataWidget: PortfolioAppBarData(
        price: 432,
        controller: controller,
        onPress: () {},
      ),
      loading: true,
      error: false,
      errorWidget: Container(),
    );
  }
}

class PortfolioAppBarData extends StatefulWidget {
  final ScrollController controller;
  final double price;
  final VoidCallback onPress;
  const PortfolioAppBarData({
    Key? key,
    required this.controller,
    required this.price,
    required this.onPress,
  }) : super(key: key);

  @override
  _PortfolioAppBarDataState createState() => _PortfolioAppBarDataState();
}

class _PortfolioAppBarDataState extends State<PortfolioAppBarData> {
  double textOpacity = 0;
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
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.black,
      title: Opacity(
        opacity: textOpacity,
        child: Text(
          "\$ ${widget.price}",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      actions: [
        CupertinoButton(
          child: Icon(
            Icons.add_circle_outlined,
            color: Colors.white,
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
      backgroundColor: Colors.black,
      title: Shimmer.fromColors(
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
        child: BoxShimmer(width: 48, height: 20, radius: 4),
      ),
      actions: [
        CupertinoButton(
          child: Icon(
            Icons.add_circle_outlined,
            color: Colors.white,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
