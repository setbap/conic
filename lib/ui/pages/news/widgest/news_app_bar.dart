import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsAppBarSliver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text("Discover"),
      snap: true,
      floating: true,
      centerTitle: false,
      bottom: NewsAppBar(
        child: Container(),
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
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [1, 2, 3, 4, 5, 6]
            .map<Widget>((e) => NewsChip(
                  text: 'bitcoin',
                  onPress: () {},
                ))
            .toList(),
      ),
    );
  }
}

class NewsChip extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  const NewsChip({Key? key, required this.onPress, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPress,
        child: Chip(
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
