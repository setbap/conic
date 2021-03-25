import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Center(child: Text('News page')),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Container(
            child: Text("News page"),
          ),
        ),
      ),
    );
  }
}
