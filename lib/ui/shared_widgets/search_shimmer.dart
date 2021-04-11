import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: shimmerHighlightColor,
      baseColor: shimmerBaseColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            child: BoxShimmer(
              height: 40,
              width: double.infinity,
              radius: 8,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => ListTile(
                horizontalTitleGap: 8,
                trailing: BoxShimmer(
                  height: 20,
                  width: 32,
                  radius: 4,
                ),
                leading: CircleShimmer(radius: 40),
                title: BoxShimmer(
                  height: 20,
                  width: 32,
                  radius: 4,
                ),
                subtitle: BoxShimmer(
                  height: 20,
                  width: 32,
                  radius: 4,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
