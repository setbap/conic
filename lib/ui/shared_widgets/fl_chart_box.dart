import 'dart:math';
import 'package:coingecko/coingecko.dart';
import 'package:conic/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class FLChartBox extends StatefulWidget {
  final CoinChart? chartData;

  const FLChartBox({Key? key, this.chartData}) : super(key: key);

  @override
  _FLChartBoxState createState() => _FLChartBoxState();
}

class _FLChartBoxState extends State<FLChartBox> {
  List<Color> gradientColorsGreen = [
    Colors.green.shade400.withAlpha(200),
    Colors.green.shade500.withAlpha(200),
  ];

  List<Color> gradientColorsRed = [
    Colors.red.shade400.withAlpha(200),
    Colors.red.shade500.withAlpha(200),
  ];

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    final chartData = widget.chartData!.prices!;
    final display = createDisplay(length: 8);
    final maxPrice = chartData.map((e) => e.price).reduce(max);
    final minPrice = chartData.map((e) => e.price).reduce(min);
    final priceRange = maxPrice - minPrice;
    final gradientColors = chartData.last.price - chartData.first.price > 0
        ? gradientColorsGreen
        : gradientColorsRed;

    return AspectRatio(
      aspectRatio: 1.618,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: DarkForeground,
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: display(flSpot.y),
                              style: TextStyle(
                                color: DarkTextForeground,
                                fontWeight: FontWeight.bold,
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
                    color: DarkForeground,
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: DarkForeground,
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
                    color: DarkTextForeground,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                  getTitles: (value) {
                    final time = chartData[value.toInt()].time;
                    return '${time.year}/${time.month}/${time.day}\n ${time.hour}:${time.minute}';
                  },
                  margin: 16,
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => const TextStyle(
                    color: DarkTextForeground,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  interval: (priceRange / 3.1),
                  getTitles: (value) {
                    return display(minPrice);
                  },
                  reservedSize: 40,
                  margin: 12,
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    for (var i = 0; i < widget.chartData!.prices!.length; i++)
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
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.2))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
