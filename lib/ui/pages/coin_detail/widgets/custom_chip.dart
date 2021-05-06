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
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
