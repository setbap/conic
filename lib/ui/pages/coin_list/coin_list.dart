import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/index_page_model.dart';
import 'package:conic/ui/pages/coin_list/widgets/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/shimmer_utils.dart';
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
      child: CustomScrollView(
        slivers: [
          CoinExchangeAppBar(tabController: tabController),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              physics: BouncingScrollPhysics(),
              children: [
                BlocConsumer<ListPageDataCubit,
                    GenericPageStete<ListPageDataModel>>(
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
                              context.read<ListPageDataCubit>().getListData();
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
                          final topCoinItem = state.data!.topCoinList;
                          return CoinListItemData(
                            imageSrc: topCoinItem[index].image,
                            name: topCoinItem[index].name,
                            chartData: topCoinItem[index].sparklineIn7d!.price,
                            change: topCoinItem[index].priceChangePercentage24h,
                            id: topCoinItem[index].symbol,
                            marketCap: topCoinItem[index].marketCap,
                            price: topCoinItem[index].currentPrice,
                            rank: topCoinItem[index].marketCapRank,
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: state.data?.topCoinList.length ?? 0,
                      ),
                      loading: state.isLoading,
                      error: false,
                    );
                  },
                ),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
