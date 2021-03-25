
import 'package:flutter/material.dart';

class ChangeShow extends StatelessWidget {
  const ChangeShow({
    Key? key,
    required this.change,
  }) : super(key: key);

  final double change;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            change.toStringAsFixed(4),
            style: TextStyle(
              color: change > 0 ? Colors.green : Colors.red,
              fontSize: 10,
            ),
          ),
          change > 0
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
