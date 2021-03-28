
import 'package:conic/utils/colors.dart';
import 'package:flutter/material.dart';

class KeyValueData extends StatelessWidget {
  final String dataKey;
  final double dataValue;
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
        "\$ $dataValue",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
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
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: DarkTextForeground,
                ),
              ),
              dataValueWidget,
            ],
          ),
        ));
  }
}
