import 'package:conic/ui/pages/buy_coin/buy_coin.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatelessWidget {
  static const String route = "/add_transaction";
  static String get routeRegEx => "/add_transaction";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Transaction'),
        centerTitle: false,
      ),
      body: CoinSearch(
          hasArrow: true,
          onPressed: ({required id}) {
            Navigator.pushNamed(context, BuyCoin.route, arguments: id);
          }),
    );
  }
}
