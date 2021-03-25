import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeeAllNews extends StatelessWidget {
  final VoidCallback onPress;
  const SeeAllNews({
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPress,
          child: Text(
            "See All news",
            style:
                Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
