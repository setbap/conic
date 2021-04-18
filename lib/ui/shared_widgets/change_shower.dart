import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class ChangeShow extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  const ChangeShow({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.change,
  }) : super(key: key);

  final double change;

  @override
  Widget build(BuildContext context) {
    final display = createDisplay(length: 8);

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            display(change),
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
