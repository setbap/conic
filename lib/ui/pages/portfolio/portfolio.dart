import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yeet/yeet.dart';

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
    controller.dispose();
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
                        context.read<PortfolioPageDataCubit>().getPortfolioData(
                              portfolioItems: portfolioItems,
                            );
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
              return CupertinoPageScaffold(
                child: CustomScrollView(
                  controller: controller,
                  slivers: [
                    PortfolioAppBar(
                      controller: controller,
                      onPress: () {},
                      price: 21,
                    ),
                    PriceChange(
                      change: 2,
                      price: 1,
                    ),
                    SliverChartBoxLoading(),
                    PortfollioTableHeader(),
                    SliverToBoxAdapter(
                        child: Divider(
                      thickness: 3,
                    )),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          final coinPriceInfo = state.data?.coinsList[index];
                          final coinPortfolioInfo = state.isLoading
                              ? portfolioItems.values.elementAt(index)
                              : state.isLoading
                                  ? null
                                  : box.get(coinPriceInfo?.id);
                          return PortfolioTableDataRow(
                            change: state.isLoading
                                ? 0
                                : coinPriceInfo!.currentPrice! -
                                    coinPortfolioInfo!.price,
                            isLoading: state.isLoading,
                            coinCount: coinPortfolioInfo!.count,
                            id: coinPortfolioInfo.id,
                            imageSrc: coinPortfolioInfo.image,
                            symbol: coinPortfolioInfo.symbol,
                            name: coinPortfolioInfo.name,
                            onPress: () {},
                            price: coinPriceInfo?.currentPrice,
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
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "Add Transaction",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          context.yeet(AddTransaction.route());
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
