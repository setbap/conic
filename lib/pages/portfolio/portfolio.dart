import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Center(child: Text('Portfolio page')),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Container(
            child: Text("Portfolio page"),
          ),
        ),
      ),
    );
  }
}
