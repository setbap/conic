import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyShimmer extends StatelessWidget {
  final Widget child;
  const MyShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: shimmerHighlightColor,
      baseColor: shimmerBaseColor,
      child: child,
    );
  }
}

class LoadingShimmer extends StatelessWidget {
  final Widget loadingWidget;
  final Widget? errorWidget;
  final Widget dataWidget;
  final bool loading;
  final bool error;

  const LoadingShimmer({
    Key? key,
    required this.loadingWidget,
    this.errorWidget,
    required this.dataWidget,
    required this.loading,
    required this.error,
  })  : assert(!error || errorWidget != null,
            "when error is true you must fill errorWidget"),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    if (loading) return loadingWidget;
    if (error) return errorWidget!;
    return dataWidget;
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
        color: Theme.of(context).backgroundColor,
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
        color: Theme.of(context).backgroundColor,
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
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}

final Color shimmerHighlightColor = Colors.red;
final Color shimmerBaseColor = Color(0xFF222222);
