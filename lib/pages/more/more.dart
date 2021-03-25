import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Center(child: Text('More page')),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Container(
            child: Text("More page"),
          ),
        ),
      ),
    );
  }
}
