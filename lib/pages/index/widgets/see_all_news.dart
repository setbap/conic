import 'package:conic/pages/news/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeeAllNews extends StatelessWidget {
  const SeeAllNews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => News(),
              ),
            );
          },
          child: Text(
            "See All news",
            style:
            Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
