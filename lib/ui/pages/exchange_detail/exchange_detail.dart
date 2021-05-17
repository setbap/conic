import 'package:coingecko/coingecko.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/ui/pages/coin_detail/widgets/coin_detail_app_bar.dart';
import 'package:conic/ui/pages/exchange_detail/widgets/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';

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
                      "Links",
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
                      "Exchange State",
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
                    ExchangeDetailAppBar(
                      name: exchangeDetail.name,
                      imageSrc: exchangeDetail.image,
                      controller: _controller,
                    ),
                    SliverChartBox(
                      title: "${exchangeDetail.name} BTC Valoum",
                      currentPrice: exchangeDetail.tradeVolume24hBtcNormalized,
                      changeEnding: "BTC",
                      priceEnding: "BTC",
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
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16, right: 8, left: 8),
                        child: Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Exchange State",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Theme.of(context).cardColor),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ExchangeInfoShow(
                        btcVolume: exchangeDetail.tradeVolume24hBtc,
                        countery: exchangeDetail.country,
                        isCentralized: exchangeDetail.centralized,
                        rank: exchangeDetail.trustScoreRank.toString(),
                        trustScore: exchangeDetail.trustScore.toString(),
                        yearEstablished:
                            exchangeDetail.yearEstablished.toString(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Social Media",
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Theme.of(context).cardColor),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          LinkListItem(
                            netImg: exchangeDetail.image,
                            iconPath: "assets/img/home.png",
                            text: "Home",
                            url: exchangeDetail.url,
                          ),
                          LinkListItem(
                            iconPath: "assets/img/fb.png",
                            text: "Facebook",
                            url: exchangeDetail.facebookUrl,
                          ),
                          LinkListItem(
                            iconPath: "assets/img/twtr.png",
                            text: "Twitter",
                            url: exchangeDetail.twitterHandle == null
                                ? null
                                : "https://twitter.com/${exchangeDetail.twitterHandle}",
                          ),
                          LinkListItem(
                            iconPath: "assets/img/tg.png",
                            text: "Telegram",
                            url: exchangeDetail.telegramUrl,
                          ),
                          LinkListItem(
                            iconPath: "assets/img/rdit.png",
                            text: "Reddit",
                            url: exchangeDetail.redditUrl,
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(padding: EdgeInsets.all(16)),
                    if (exchangeDetail.statusUpdates.length > 0)
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Latest Update",
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Theme.of(context).cardColor,
                                    ),
                          ),
                        ),
                      ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = exchangeDetail.statusUpdates[index];
                        return Container(
                          child: Card(
                            color: Colors.grey,
                            child: Column(
                              children: [
                                Text(item.userTitle),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        item.project.image.small,
                                        width: 32,
                                        height: 32,
                                      ),
                                      Text(item.project.name),
                                      Text(item.project.type),
                                    ],
                                  ),
                                ),
                                Text(item.description),
                              ],
                            ),
                          ),
                        );
                      }, childCount: exchangeDetail.statusUpdates.length),
                    ),
                    SliverPadding(padding: EdgeInsets.all(16)),
                    if (exchangeDetail.tickers.length > 0)
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Tickers",
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Theme.of(context).cardColor,
                                    ),
                          ),
                        ),
                      ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = exchangeDetail.tickers[index];
                        return ListTile(
                          onTap: () async {
                            if (item.tradeUrl != null) {
                              final x = await canLaunch(item.tradeUrl!);
                              if (x) {
                                await launch(item.tradeUrl!);
                              }
                            }
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.base} ->",
                              ),
                              Text(
                                " ${item.target}",
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "${item.convertedLast?.usd} \$",
                              ),
                            ],
                          ),
                          trailing: Text(
                            "val :${item.convertedVolume?.usd}",
                          ),
                          leading: CircleAvatar(
                            radius: 16,
                            backgroundColor: item.trustScore == "green"
                                ? Colors.green
                                : Colors.red,
                            child: Container(),
                          ),
                        );
                      }, childCount: exchangeDetail.tickers.length),
                    ),
                    SliverPadding(padding: EdgeInsets.all(48)),
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

class LinkListItem extends StatelessWidget {
  final String? url;
  final String? text;
  final String? netImg;
  final String iconPath;
  const LinkListItem({
    Key? key,
    this.url,
    this.text,
    this.netImg,
    required this.iconPath,
  }) : super(key: key);

  Widget build(BuildContext context) {
    if (url == null || url?.trim() == "") {
      return Container();
    }
    return OutlinedButton(
      onPressed: () async {
        final canOpenLink = await canLaunch(url!);
        if (canOpenLink) {
          launch(url!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: netImg != null
                  ? Image.network(
                      netImg!,
                      width: 24,
                      height: 24,
                    )
                  : Image.asset(
                      iconPath,
                      width: 24,
                      height: 24,
                    ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              text ?? "",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
