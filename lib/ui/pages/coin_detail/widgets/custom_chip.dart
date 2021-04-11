import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  const CustomChip({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          color: DarkForeground,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
