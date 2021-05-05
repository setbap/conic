import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/ui/pages/coin_detail/widgets/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/colors.dart';
import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinDetail extends StatefulWidget {
  const CoinDetail({Key? key, required this.id}) : super(key: key);

  static const String route = "coin/detail";
  static String get routeRegEx => "coin/:id";
  final String id;

  @override
  _CoinDetailState createState() => _CoinDetailState();
}

class _CoinDetailState extends State<CoinDetail> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<CoinDetailPageDataCubit>().getCoinDetailData(widget.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CoinDetailPageDataCubit,
          GenericPageStete<CoinDetailPageDataModel>>(
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
                        .read<CoinDetailPageDataCubit>()
                        .getCoinDetailData(widget.id);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'retry',
                    style: TextStyle(color: Colors.white),
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
                        child: Text(" ", style: TextStyle(color: Colors.white)),
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
                          .copyWith(color: Colors.white),
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
                          .copyWith(color: Colors.white),
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
                      color: DarkForeground,
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
                final coinPrice = state.data!.coinPrice;
                final coinDecription = state.data?.coinDecription;
                return CustomScrollView(
                  controller: _controller,
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    CoinDetailAppBar(
                      symbol: coinPrice.symbol.toUpperCase(),
                      price: coinPrice.currentPrice!,
                      imageSrc: coinPrice.image ?? "",
                      controller: _controller,
                    ),
                    PriceChange(
                      change: coinPrice.priceChange24h,
                      price: coinPrice.currentPrice!,
                    ),
                    SliverChartBox(chartDataArray: [
                      state.data!.oneDayChartData,
                      state.data!.sevenDayChartData,
                      state.data!.thirtyDayChartData,
                      state.data!.allTimeChartData,
                    ]),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Ads",
                                style: TextStyle(color: Colors.white)),
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
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: PriceData(
                        ath: coinPrice.ath,
                        high: coinPrice.high24h,
                        changePercentage: coinPrice.priceChangePercentage24h,
                        atl: coinPrice.atl,
                        low: coinPrice.low24h,
                        change: coinPrice.priceChange24h,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Market State",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: MarketState(
                        mktCap: coinPrice.marketCap,
                        sentimentVotesUpPercentage:
                            coinDecription?.sentimentVotesUpPercentage,
                        rank: coinPrice.marketCapRank,
                        coingeckoScore: coinDecription?.coingeckoScore,
                        sentimentVotesDownPercentage:
                            coinDecription?.sentimentVotesDownPercentage,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16, right: 8, left: 8),
                        child: Divider(
                          color: DarkForeground,
                        ),
                      ),
                    ),
                    CoinAbout(
                      coinDecription: coinDecription,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 120,
                      ),
                    ),
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
