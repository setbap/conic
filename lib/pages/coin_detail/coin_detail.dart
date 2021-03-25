import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Center(child: Text('CoinDetail page')),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Container(
            child: Text("CoinDetail page"),
          ),
        ),
      ),
    );
  }
}
