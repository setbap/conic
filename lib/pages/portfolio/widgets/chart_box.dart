import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';

class SliverChartBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Placeholder(
              fallbackHeight: 250,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              timeButton(
                text: '24h',
                currentTime: '7d',
                onPress: () {},
              ),
              timeButton(
                text: '7d',
                currentTime: '7d',
                onPress: () {},
              ),
              timeButton(
                text: '30d',
                currentTime: '7d',
                onPress: () {},
              ),
              timeButton(
                text: 'all',
                currentTime: '7d',
                onPress: () {},
              ),
            ],
          )
        ]),
      ),
    );
  }
  Container timeButton({
    required String text,
    required VoidCallback onPress,
    required String currentTime,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: text == currentTime ? DarkForeground : Colors.transparent,
          borderRadius: BorderRadius.circular(8)),
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: text == currentTime ? Colors.white : DarkTextForeground),
        ),
      ),
    );
  }
}
