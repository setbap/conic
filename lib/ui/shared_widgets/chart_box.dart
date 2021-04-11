import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SliverChartBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      loadingWidget: SliverChartBoxLoading(),
      dataWidget: SliverChartBoxData(),
      loading: true,
    );
  }
}

class SliverChartBoxData extends StatelessWidget {
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

class SliverChartBoxLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Shimmer.fromColors(
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: BoxShimmer(height: 250, width: double.infinity, radius: 8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BoxShimmer(height: 24, width: 40, radius: 4),
                BoxShimmer(height: 24, width: 40, radius: 4),
                BoxShimmer(height: 24, width: 40, radius: 4),
                BoxShimmer(height: 24, width: 40, radius: 4),
              ],
            )
          ]),
        ),
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
