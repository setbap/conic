import 'package:conic/manager/transaction_storage.dart';
import 'package:conic/ui/pages/single_coin_history/single_coin_history.dart';
import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/ui/pages/add_transaction/add_transaction.dart';
import 'package:conic/ui/pages/portfolio/widgets/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  ScrollController controller = ScrollController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<PortfolioStorage>>(
        valueListenable:
            Hive.box<PortfolioStorage>(PortfolioStorage.PortfolioKey)
                .listenable(),
        builder: (context, box, widget) {
          final portfolioItems = box.toMap().cast<String, PortfolioStorage>();
          context.read<PortfolioPageDataCubit>().getPortfolioData(
              portfolioItems: box.toMap().cast<String, PortfolioStorage>());
          return BlocConsumer<PortfolioPageDataCubit,
              GenericPageStete<PortfolioPageDataModel>>(
            listenWhen: (previous, current) {
              return !previous.isError == current.isError;
            },
            listener: (context, state) {
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
                        context.read<PortfolioPageDataCubit>().getPortfolioData(
                              portfolioItems: portfolioItems,
                            );
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
              return CupertinoPageScaffold(
                child: CustomScrollView(
                  controller: controller,
                  slivers: [
                    LoadingShimmer(
                      error: false,
                      loading: state.isLoading,
                      loadingWidget: PortfolioAppBarLoading(),
                      dataWidget: PortfolioAppBar(
                        controller: controller,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            AddTransaction.route,
                          );
                        },
                        price: state.data?.currentPrice ?? 0,
                      ),
                    ),
                    LoadingShimmer(
                      error: false,
                      loading: state.isLoading,
                      loadingWidget: PriceChangeLoading(),
                      dataWidget: PriceChange(
                        change: state.data?.priceChange ?? 0,
                        price: state.data?.currentPrice ?? 0,
                      ),
                    ),
                    LoadingShimmer(
                      error: false,
                      loading: state.isLoading,
                      loadingWidget: SliverChartBoxLoading(),
                      dataWidget: SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 25),
                          child: MyLineChart(
                            width: MediaQuery.of(context).size.width - 80,
                            height: 240,
                            chartData: state.data?.sparkLine ?? [],
                          ),
                        ),
                      ),
                    ),
                    PortfollioTableHeader(),
                    SliverToBoxAdapter(
                      child: Divider(
                        thickness: 3,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          if (state.isLoading ||
                              (state.data?.coinsList.length ?? 0) <= index) {
                            return Container(
                              height: 30,
                            );
                          }
                          final coinPriceInfo = state.data?.coinsList[index];
                          final coinPortfolioInfo = box.get(coinPriceInfo?.id);
                          if (coinPortfolioInfo == null) {
                            return Container(
                              height: 30,
                            );
                          }
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            background: Container(
                              padding: EdgeInsets.all(8),
                              alignment: AlignmentDirectional.centerStart,
                              color: Theme.of(context).primaryColor,
                              child: Text(
                                "DELETE ${coinPortfolioInfo.id}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).backgroundColor,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            onDismissed: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                // TODO: imporve This part
                                TransactionManager().sellAll(
                                  coinId: coinPortfolioInfo.id,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("${coinPortfolioInfo.id} deleted"),
                                  ),
                                );
                              }
                            },
                            key: Key(coinPortfolioInfo.id),
                            child: PortfolioTableDataRow(
                              change: state.isLoading
                                  ? 0
                                  : coinPriceInfo!.currentPrice! -
                                      coinPortfolioInfo.price,
                              isLoading: state.isLoading,
                              coinCount: coinPortfolioInfo.count,
                              id: coinPortfolioInfo.id,
                              imageSrc: coinPortfolioInfo.image,
                              symbol: coinPortfolioInfo.symbol,
                              name: coinPortfolioInfo.name,
                              onPress: () {
                                Navigator.pushNamed(
                                  context,
                                  SingleCoinHistory.route,
                                  arguments: coinPortfolioInfo.id,
                                );
                              },
                              price: coinPriceInfo?.currentPrice,
                            ),
                          );
                        },
                        childCount: portfolioItems.length,
                      ),
                    ),
                    if (portfolioItems.length == 0)
                      SliverPadding(
                        padding: EdgeInsets.all(
                          32,
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "Add Transaction",
                            style:
                                TextStyle(color: Theme.of(context).cardColor),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AddTransaction.route,
                          );
                          // box.put(
                          //   'bitcoin',
                          //   PortfolioStorage(
                          //     id: 'bitcoin',
                          //     name: 'Bitcoin',
                          //     image:
                          //         "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
                          //     symbol: 'btc',
                          //     price: 54808,
                          //     fee: 1,
                          //     desc: "no null",
                          //     count: 1,
                          //   ),
                          // );
                        },
                      ),
                    ),
                    SliverPadding(padding: EdgeInsets.only(top: 100))
                  ],
                ),
              );
            },
          );
        });
  }
}
