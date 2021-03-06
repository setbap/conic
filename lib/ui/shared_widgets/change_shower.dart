import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class ChangeShow extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final String ending;
  final double fontSize;
  final int lenCount;
  const ChangeShow({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.change,
    this.ending = "\%",
    this.fontSize = 10,
    this.lenCount = 8,
  }) : super(key: key);

  final double? change;

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(length: lenCount);

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            "${display(change)} $ending",
            style: TextStyle(
              color: (change ?? 0) > 0 ? Colors.green : Colors.red,
              fontSize: fontSize,
            ),
          ),
          (change ?? 0) > 0
              ? Icon(
                  Icons.arrow_drop_up,
                  color: Colors.green,
                )
              : Icon(
                  Icons.arrow_drop_down,
                  color: Colors.red,
                ),
        ],
      ),
    );
  }
}
