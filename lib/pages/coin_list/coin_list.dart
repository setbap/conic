import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Center(child: Text('CoinList page')),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Container(
            child: Text("CoinList page"),
          ),
        ),
      ),
    );
  }
}
