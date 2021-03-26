import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndexToolsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      IndexToolsItem(
        backgroundColor: WatchListColor,
        text: 'Watch list',
        icon: Icon(
          Icons.backup_table_outlined,
          color: Colors.white,
        ),
        onPress: () {
          // Navigator.push(
          //   context,
          //   CupertinoPageRoute(
          //     builder: (context) => WatchList(),
          //   ),
          // );
        },
      ),
      IndexToolsItem(
          backgroundColor: ConvertColor,
          text: 'Convert',
          icon: Icon(
            Icons.info_outline,
            color: Colors.white,
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
        childCount: 2,
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
        color: DarkForeground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
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
