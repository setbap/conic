import 'dart:math';
import 'package:coingecko/coingecko.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class FLChartBox extends StatefulWidget {
  final List<CoinChart>? chartData;
  final int? activeIndex;

  const FLChartBox(
      {Key? key, required this.chartData, required this.activeIndex})
      : super(key: key);

  @override
  _FLChartBoxState createState() => _FLChartBoxState();
}

class _FLChartBoxState extends State<FLChartBox> {
  @override
  Widget build(BuildContext context) {
    // final chartData = widget.chartData![widget.activeIndex!].prices!;

    return AspectRatio(
      aspectRatio: 1.618,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Chartic(
            chartData: widget.chartData![widget.activeIndex!].prices!,
          ),
        ),
      ),
    );
  }
}

class Chartic extends StatelessWidget {
  final List<CoinChartTimeData> chartData;

  const Chartic({Key? key, required this.chartData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColorsGreen = [
      Colors.green.shade400.withAlpha(200),
      Colors.green.shade500.withAlpha(200),
    ];
    List<Color> gradientColorsRed = [
      Colors.red.shade400.withAlpha(200),
      Colors.red.shade500.withAlpha(200),
    ];
    final display = createDisplay(length: 8);
    final maxPrice = chartData.map((e) => e.price).reduce(max);
    final minPrice = chartData.map((e) => e.price).reduce(min);
    final priceRange = maxPrice - minPrice;
    final gradientColors = chartData.last.price - chartData.first.price > 0
        ? gradientColorsGreen
        : gradientColorsRed;

    return LineChart(LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Theme.of(context).cardColor,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                if (flSpot.x == 0) {
                  return null;
                }
                final time = chartData[flSpot.x.toInt()].time;
                return LineTooltipItem(
                  '${time.year}/${time.month}/${time.day} ${time.hour}:${time.minute}  \n',
                  const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 11,
                  ),
                  children: [
                    TextSpan(
                      text: display(flSpot.y),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    TextSpan(
                      text: '\$',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }).toList();
            }),
      ),
      gridData: FlGridData(
        show: true,
        verticalInterval: chartData.length / 6,
        horizontalInterval: priceRange / 4,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).chipTheme.backgroundColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Theme.of(context).chipTheme.backgroundColor,
            strokeWidth: 1,
          );
        },
      ),
      // minY: minPrice - (priceRange * 0.1),
      // maxY: maxPrice + (priceRange * 0.1),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          interval: (chartData.length / 2) - 5,
          getTextStyles: (value) => const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 10,
          ),
          getTitles: (value) {
            if (value.toInt() >= chartData.length) {
              return "";
            }
            final time = chartData[value.toInt()].time;
            return '${time.year}/${time.month}/${time.day}\n ${time.hour}:${time.minute}';
          },
          margin: 16,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => TextStyle(
            color: Theme.of(context).colorScheme.secondaryVariant,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          interval: (priceRange / 4),
          getTitles: (value) {
            return display(value);
          },
          reservedSize: 40,
          margin: 12,
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (var i = 0; i < chartData.length; i++)
              FlSpot(i.toDouble(), chartData[i].price),
          ],
          isCurved: false,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: false,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.2)).toList(),
          ),
        ),
      ],
    ));
  }
}
