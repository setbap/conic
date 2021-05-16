import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/material.dart';

class KeyValueData extends StatelessWidget {
  final String dataKey;
  final String dataValue;
  final String ending;
  const KeyValueData({
    Key? key,
    required this.dataKey,
    required this.dataValue,
    this.ending = "\$",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyValueDataGeneric(
      dataKey: dataKey,
      dataValueWidget: Text(
        "$dataValue $ending",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}

class KeyValueDataGeneric extends StatelessWidget {
  final String dataKey;
  final Widget dataValueWidget;
  const KeyValueDataGeneric({
    Key? key,
    required this.dataKey,
    required this.dataValueWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              dataKey,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          dataValueWidget,
        ],
      ),
    ));
  }
}

class KeyValueDataLoading extends StatelessWidget {
  const KeyValueDataLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoxShimmer(height: 16, width: 40, radius: 4),
          BoxShimmer(height: 16, width: 40, radius: 4),
        ],
      ),
    ));
  }
}
