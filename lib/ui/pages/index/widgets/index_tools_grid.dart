import 'package:conic/ui/pages/fiv_coins/fiv_coins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndexToolsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      IndexToolsItem(
        backgroundColor: Color(0xff7A6FFC),
        text: 'Fav list',
        icon: Icon(
          Icons.favorite,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPress: () {
          Navigator.pushNamed(context, FivCoins.route);
        },
      ),
      IndexToolsItem(
          backgroundColor: Color(0xff3661FB),
          text: 'Convert',
          icon: Icon(
            Icons.info_outline,
            color: Theme.of(context).cardColor,
          ),
          onPress: () {
            // Navigator.push(
            //   context,
            //   CupertinoPageRoute(
            //     builder: (context) => WatchList(),
            //   ),
            // );
          }),
    ];
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => items[index],
        childCount: 1,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        mainAxisExtent: 70,
      ),
    );
  }
}

class IndexToolsItem extends StatelessWidget {
  final String text;
  final VoidCallback onPress;
  final Color backgroundColor;
  final Widget icon;

  const IndexToolsItem({
    Key? key,
    required this.text,
    required this.onPress,
    required this.backgroundColor,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(
          onTap: onPress,
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: icon,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: backgroundColor,
                ),
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
