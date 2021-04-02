import 'package:flutter/material.dart';

class LoadingShimmer extends StatelessWidget {
  final Widget loadingWidget;
  final Widget dataWidget;
  final bool loading;

  const LoadingShimmer({
    Key? key,
    required this.loadingWidget,
    required this.dataWidget,
    required this.loading,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return loading ? loadingWidget : dataWidget;
  }
}

class CircleShimmer extends StatelessWidget {
  final double radius;

  const CircleShimmer({Key? key, required this.radius}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.black,
      ),
    );
  }
}

class SquareShimmer extends StatelessWidget {
  final double radius;
  final double size;

  const SquareShimmer({Key? key, required this.size, required this.radius})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.black,
      ),
    );
  }
}

class BoxShimmer extends StatelessWidget {
  final double radius;
  final double width;
  final double height;

  const BoxShimmer({
    Key? key,
    required this.height,
    required this.width,
    required this.radius,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Colors.black,
      ),
    );
  }
}

final Color shimmerHighlightColor = Colors.red;
final Color shimmerBaseColor = Color(0xFF222222);
