import 'package:coingecko/coingecko.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/ui/pages/coin_detail/widgets/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchnageDetail extends StatefulWidget {
  const ExchnageDetail({Key? key, required this.id}) : super(key: key);

  static const String route = "exchange/detail";
  static String get routeRegEx => "exchange/:id";
  final String id;

  @override
  _ExchnageDetailState createState() => _ExchnageDetailState();
}

class _ExchnageDetailState extends State<ExchnageDetail> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    context
        .read<ExchangeDetailPageDataCubit>()
        .getExchangeDetailData(widget.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ExchangeDetailPageDataCubit,
          GenericPageStete<ExchangeDetailPageDataModel>>(
        listenWhen: (previous, current) {
          return !previous.isError && current.isError;
        },
        listener: (context, state) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(
                'Error',
                style: TextStyle(color: Colors.red),
              ),
              content: Text('an Error with you connection'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('dismiss'),
                ),
                TextButton(
                  onPressed: () {
                    context
                        .read<ExchangeDetailPageDataCubit>()
                        .getExchangeDetailData(widget.id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'retry',
                    style: TextStyle(color: Theme.of(context).cardColor),
                  ),
                ),
              ],
            ),
          );
        },
        builder: (context, state) {
          return LoadingShimmer(
            loadingWidget: CustomScrollView(
              controller: _controller,
              physics: BouncingScrollPhysics(),
              slivers: [
                CoinDetailAppBarLoading(),
                PriceChangeLoading(),
                SliverChartBoxLoading(),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(" ",
                            style:
                                TextStyle(color: Theme.of(context).cardColor)),
                      ),
                    ),
                  ),
                ),
                SliverPadding(padding: EdgeInsets.all(8)),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Price (24H)",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Theme.of(context).cardColor),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: PriceDataLoading(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Market State",
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Theme.of(context).cardColor),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: PriceDataLoading(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16, right: 8, left: 8),
                    child: Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                CoinAboutLoading(),
                SliverToBoxAdapter(
                  child: Container(
                    height: 120,
                  ),
                ),
              ],
            ),
            dataWidget: Builder(
              builder: (context) {
                final exchangeDetail = state.data!.exchangeDetail;
                final oneDayChartData = state.data!.oneDayChartData;
                final sevenDayChartData = state.data!.sevenDayChartData;
                final thirtyDayChartData = state.data!.thirtyDayChartData;
                final allTimeChartData = state.data!.allTimeChartData;

                return CustomScrollView(
                  controller: _controller,
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    CoinDetailAppBar(
                      symbol: exchangeDetail.name,
                      id: exchangeDetail.name,
                      price: exchangeDetail.tradeVolume24hBtcNormalized,
                      imageSrc: exchangeDetail.image,
                      controller: _controller,
                    ),
                    SliverChartBox(
                      currentPrice: exchangeDetail.tradeVolume24hBtcNormalized,
                      chartDataArray: [
                        CoinChart(prices: oneDayChartData.prices),
                        CoinChart(prices: sevenDayChartData.prices),
                        CoinChart(prices: thirtyDayChartData.prices),
                        CoinChart(prices: allTimeChartData.prices),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Ads",
                                style: TextStyle(
                                  color: Theme.of(context).cardColor,
                                )),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(padding: EdgeInsets.all(8)),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Price (24H)",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Theme.of(context).cardColor),
                        ),
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //   child: PriceData(
                    //     ath: coinPrice.ath,
                    //     high: coinPrice.high24h,
                    //     changePercentage: coinPrice.priceChangePercentage24h,
                    //     atl: coinPrice.atl,
                    //     low: coinPrice.low24h,
                    //     change: coinPrice.priceChange24h,
                    //   ),
                    // ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Market State",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Theme.of(context).cardColor),
                        ),
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //   child: MarketState(
                    //     mktCap: coinPrice.marketCap,
                    //     sentimentVotesUpPercentage:
                    //         coinDecription?.sentimentVotesUpPercentage,
                    //     rank: coinPrice.marketCapRank,
                    //     coingeckoScore: coinDecription?.coingeckoScore,
                    //     sentimentVotesDownPercentage:
                    //         coinDecription?.sentimentVotesDownPercentage,
                    //   ),
                    // ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16, right: 8, left: 8),
                        child: Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    // CoinAbout(
                    //   coinDecription: coinDecription,
                    // ),
                  ],
                );
              },
            ),
            loading: state.isLoading,
            error: false,
          );
        },
      ),
    );
  }
}
