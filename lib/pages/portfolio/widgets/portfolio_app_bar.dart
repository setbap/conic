import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      }  else if (offset > 70 && textOpacity < 0.98) {
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
