import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/ui/pages/coin_detail/coin_detail.dart';
import 'package:conic/ui/pages/coin_list/widgets/widgets.dart';
import 'package:conic/ui/pages/search/search.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinList extends StatefulWidget {
  @override
  _CoinListState createState() => _CoinListState();
  final int _kTabCount = 2;
}

class _CoinListState extends State<CoinList>
    with SingleTickerProviderStateMixin {
  late final tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(vsync: this, length: widget._kTabCount, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget._kTabCount,
      child:
          BlocConsumer<ListPageDataCubit, GenericPageStete<ListPageDataModel>>(
        listenWhen: (previous, current) {
          return !previous.isError && current.isError;
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
                    context.read<ListPageDataCubit>().getListData();
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
          return CustomScrollView(
            slivers: [
              CoinExchangeAppBar(
                tabController: tabController,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Search.route,
                  );
                },
              ),
              SliverFillRemaining(
                child: TabBarView(
                  controller: tabController,
                  physics: BouncingScrollPhysics(),
                  children: [
                    LoadingShimmer(
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
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.amber,
                        ),
                        itemCount: 20,
                      ),
                      dataWidget: ListView.separated(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 4,
                          bottom: 20,
                          top: 16,
                        ),
                        itemBuilder: (context, index) {
                          final topCoinItem = state.data!.topCoinList[index];
                          return CoinListItemData(
                            onPressed: () {
                              Navigator.pushNamed(context, CoinDetail.route,
                                  arguments: topCoinItem.id);
                            },
                            imageSrc: topCoinItem.image ?? "",
                            name: topCoinItem.name,
                            chartData: topCoinItem.sparklineIn7d!.price,
                            change: topCoinItem.priceChangePercentage24h,
                            id: topCoinItem.symbol,
                            marketCap: topCoinItem.marketCap,
                            price: topCoinItem.currentPrice!,
                            rank: topCoinItem.marketCapRank,
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          color: Theme.of(context).disabledColor,
                        ),
                        itemCount: state.data?.topCoinList.length ?? 0,
                      ),
                      loading: state.isLoading,
                      error: false,
                    ),
                    LoadingShimmer(
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
                      dataWidget: ListView.separated(
                        padding: const EdgeInsets.only(
                          left: 4,
                          right: 4,
                          bottom: 94,
                          top: 16,
                        ),
                        itemBuilder: (context, index) {
                          return ExchnageListItem(
                            exchangesItem: state.data!.topExchangeList[index],
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: state.data?.topCoinList.length ?? 0,
                      ),
                      loading: state.isLoading,
                      error: false,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
