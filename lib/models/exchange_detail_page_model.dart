import 'package:coingecko/coingecko.dart';

class ExchangeDetailPageDataModel {
  final ExchangeDetail exchangeDetail;
  final ExchangeChart oneDayChartData;
  final ExchangeChart sevenDayChartData;
  final ExchangeChart thirtyDayChartData;
  final ExchangeChart allTimeChartData;

  ExchangeDetailPageDataModel({
    required this.exchangeDetail,
    required this.oneDayChartData,
    required this.sevenDayChartData,
    required this.thirtyDayChartData,
    required this.allTimeChartData,
  });

  @override
  String toString() {
    return 'ExchangeDetailPageDataModel(exchangeDetail: $exchangeDetail, oneDayChartData: $oneDayChartData, sevenDayChartData: $sevenDayChartData, thirtyDayChartData: $thirtyDayChartData, allTimeChartData: $allTimeChartData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExchangeDetailPageDataModel &&
        other.exchangeDetail == exchangeDetail &&
        other.oneDayChartData == oneDayChartData &&
        other.sevenDayChartData == sevenDayChartData &&
        other.thirtyDayChartData == thirtyDayChartData &&
        other.allTimeChartData == allTimeChartData;
  }

  @override
  int get hashCode {
    return exchangeDetail.hashCode ^
        oneDayChartData.hashCode ^
        sevenDayChartData.hashCode ^
        thirtyDayChartData.hashCode ^
        allTimeChartData.hashCode;
  }
}
