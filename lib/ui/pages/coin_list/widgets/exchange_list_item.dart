import 'package:coingecko/coingecko.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class ExchnageListItem extends StatelessWidget {
  final ExchangesItem exchangesItem;
  final VoidCallback onPressed;

  const ExchnageListItem(
      {Key? key, required this.exchangesItem, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberDisplay = createDisplay(length: 4);
    return ListTile(
      onTap: onPressed,
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      leading: CircleAvatar(
        radius: 18,
        child: Image.network(
          exchangesItem.image!,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(exchangesItem.name),
      ),
      subtitle: Row(
        children: [
          Container(
            width: 21,
            child: Icon(
              Icons.shield_rounded,
              size: 18,
              color: (exchangesItem.trustScore ?? 0) > 5
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          Container(
            width: 20,
            child: Text(
              exchangesItem.trustScore.toString(),
              style: TextStyle(
                color: (exchangesItem.trustScore ?? 0) > 5
                    ? Colors.green
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
            child: Text(
              exchangesItem.trustScoreRank.toString(),
              style: TextStyle(fontSize: 11),
            ),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      trailing: Text(
        'btc trade val: ${numberDisplay(exchangesItem.tradeVolume24hBtcNormalized)}',
      ),
    );
  }
}
