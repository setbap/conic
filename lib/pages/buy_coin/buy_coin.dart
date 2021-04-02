import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyCoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text("Conic"),
            pinned: true,
            bottom: AppBar(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: CupertinoButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.golf_course,
                        color: Colors.white,
                      ),
                    ),
                  ),Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: CupertinoButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.golf_course,
                        color: Colors.white,
                      ),
                    ),
                  ),Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: CupertinoButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.golf_course,
                        color: Colors.white,
                      ),
                    ),
                  ),Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: CupertinoButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.golf_course,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) => ListTile(
                title: Text("sina"),
              ),
              childCount: 20,
            ),
          )
        ],
      ),
    );
  }
}
