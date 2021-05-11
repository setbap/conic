import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLineChart extends StatefulWidget {
  final List<double> chartData;
  final double height;
  final double width;
  const MyLineChart({
    Key? key,
    required this.chartData,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _MyLineChartState createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  Timer? timer;
  double animationPercentage = 0;
  final fps = 60;
  final duration = 2000;

  @override
  void initState() {
    super.initState();
    // final animationDuration = Duration(milliseconds: duration ~/ fps);
    // timer = Timer.periodic(animationDuration, (time) {
    //   setState(() {
    //     animationPercentage += fps / duration;
    //   });
    //   if (animationPercentage >= 1) {
    //     timer?.cancel();
    //   }
    // });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.chartData.length < 2) {
      return Container(
        height: widget.height,
        width: widget.width,
      );
    }

    return Container(
      height: widget.height,
      width: widget.width,
      child: CustomPaint(
        painter: _MyCanvas(
          chartData: widget.chartData,
          // percentage: animationPercentage,
          percentage: 1,
        ),
      ),
    );
  }
}

class _MyCanvas extends CustomPainter {
  final List<double> chartData;
  final double percentage;

  _MyCanvas({
    required this.chartData,
    this.percentage = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final center = Offset(size.width / 2, size.height / 2);
    final box = Rect.fromCenter(center: center, width: width, height: height);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    // drawFrame(canvas, center, width, height);
    drawChart(canvas, box, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawFrame(Canvas canvas, Offset center, double width, double height) {
    final rect = Rect.fromCenter(center: center, width: width, height: height);

    // color bg
    final bg = Paint()..color = Colors.grey.shade900;
    canvas.drawRect(rect, bg);

    // daraw rect
    final border = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(rect, border);
  }

  void drawChart(Canvas canvas, Rect box, Paint paint) {
    var startX = box.left;

    final maxData = chartData.reduce(max);
    final minData = chartData.reduce(min);
    final rangeData = maxData - minData;
    final yRatio = box.height / rangeData;
    final xRatio = box.width / chartData.length;
    var p = Path();

    var x = startX;
    if (chartData.length > 0) {
      // p.moveTo(x, (chartData[0] - minData) * yRatio * percentage);
      p.moveTo(x, box.height - (chartData[0] - minData) * yRatio * percentage);

      chartData.forEach((element) {
        p.lineTo(x, box.height - (element - minData) * yRatio * percentage);
        x += xRatio;
      });
    }
    // p.lineTo(box.right, box.bottom);

    // p.lineTo(box.left, box.bottom);
    // p.moveTo(x, box.height - (chartData[0] - minData) * yRatio * percentage);

    // p.close();

    if (chartData[0] - chartData[chartData.length - 1] < 0) {
      canvas.drawPath(
          p,
          paint
            ..color = Colors.green
            ..style = PaintingStyle.stroke);
    } else {
      canvas.drawPath(
        p,
        paint
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }
}
