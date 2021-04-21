import 'package:conic/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsAppBarSliver extends StatelessWidget {
  final Widget child;

  const NewsAppBarSliver({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text("News"),
      snap: true,
      floating: true,
      centerTitle: false,
      bottom: NewsAppBar(
        child: Container(
          height: 44,
          child: child,
        ),
      ),
    );
  }
}

class NewsAppBar extends PreferredSize {
  final Widget child;
  NewsAppBar({
    Key? key,
    required this.child,
  }) : super(
          key: key,
          child: child,
          preferredSize: Size(
            double.infinity,
            36,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      child: child,
    );
  }
}

class NewsChip extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onPress;
  const NewsChip({
    Key? key,
    required this.onPress,
    required this.text,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPress,
        child: Chip(
          side: BorderSide(color: Colors.transparent),
          labelStyle: TextStyle(
              color: isActive ? Colors.red : DarkTextForeground,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2),
          label: Text(text),
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
        ),
      ),
    );
  }
}
