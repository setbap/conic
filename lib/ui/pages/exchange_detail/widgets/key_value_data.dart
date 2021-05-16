import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/material.dart';

class KeyValueData extends StatelessWidget {
  final String dataKey;
  final String dataValue;
  const KeyValueData({
    Key? key,
    required this.dataKey,
    required this.dataValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyValueDataGeneric(
      dataKey: dataKey,
      dataValueWidget: Text(
        " $dataValue \$",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
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
          Text(
            dataKey,
            style: Theme.of(context).textTheme.caption,
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
