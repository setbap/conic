import 'package:conic/models/models.dart';
import 'package:conic/ui/pages/add_transaction/add_transaction.dart';
import 'package:conic/ui/pages/portfolio/widgets/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yeet/yeet.dart';

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
          final coinList = box.values.toList();
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
                      final coin = coinList[index];
                      return PortfolioTableDataRow(
                        change: 1.2,
                        isLoading: true,
                        coinCount: coin.count,
                        id: coin.id,
                        imageSrc: coin.image,
                        symbol: coin.symbol,
                        name: coin.name,
                        onPress: () {},
                        price: coin.price,
                      );
                    },
                    childCount: coinList.length,
                  ),
                ),
                if (coinList.length == 0)
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
        });
  }
}
