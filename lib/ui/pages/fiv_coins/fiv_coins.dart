import 'package:coingecko/coingecko.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/manager/manager.dart';
import 'package:conic/ui/pages/coin_detail/coin_detail.dart';
import 'package:conic/ui/pages/coin_list/widgets/widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FivCoins extends StatefulWidget {
  static const String route = "/fiv";
  static String get routeRegEx => "/fiv";

  @override
  _FivCoinsState createState() => _FivCoinsState();
}

class _FivCoinsState extends State<FivCoins> {
  List<TopCoin>? coins = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<String>>(
        valueListenable: context.read<FivManager>().fivStorageBox.listenable(),
        builder: (context, box, _) {
          if (((coins?.length ?? 0) + 1 != box.values.length)) {
            context.read<FivPageDataCubit>().getFivCoinsData(
                  coinsId: box.values.toList(),
                );
          }

          return BlocConsumer<FivPageDataCubit,
              GenericPageStete<List<TopCoin>>>(
            listener: (context, state) {
              if (state.isError)
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text(
                      'Error',
                      style: TextStyle(color: Theme.of(context).primaryColor),
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
                              .read<FivPageDataCubit>()
                              .getFivCoinsData(coinsId: box.values.toList());
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
              if (!state.isLoading || !state.isError) {
                coins = state.data;
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text("Fav Coin List"),
                ),
                body: LoadingShimmer(
                  loading: state.isLoading,
                  loadingWidget: ListView.separated(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 94,
                      top: 16,
                    ),
                    itemBuilder: (context, index) {
                      return CoinListItemLoading();
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: 20,
                  ),
                  dataWidget: (state.data == null || state.data!.isEmpty)
                      ? Center(
                          child: Column(
                            children: [
                              Icon(Icons.add_box),
                              Text(
                                "Fav List is Empty",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 4,
                            bottom: 20,
                            top: 16,
                          ),
                          itemBuilder: (context, index) {
                            final favCoinItem = state.data![index];
                            return CoinListItemData(
                              onFavPressed: () {
                                context
                                    .read<FivPageDataCubit>()
                                    .deleteFivCoinData(
                                      coinId: favCoinItem.id,
                                    );
                              },
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  CoinDetail.route,
                                  arguments: favCoinItem.id,
                                );
                              },
                              imageSrc: favCoinItem.image ?? "",
                              name: favCoinItem.name,
                              chartData: favCoinItem.sparklineIn7d!.price,
                              change: favCoinItem.priceChangePercentage24h,
                              id: favCoinItem.id,
                              symbol: favCoinItem.symbol,
                              marketCap: favCoinItem.marketCap,
                              price: favCoinItem.currentPrice!,
                              rank: favCoinItem.marketCapRank,
                              key: ValueKey(favCoinItem.id),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: Theme.of(context).disabledColor,
                          ),
                          itemCount: state.data?.length ?? 0,
                        ),
                  error: false,
                ),
              );
            },
          );
        });
  }
}
