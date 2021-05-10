import 'package:conic/manager/transaction_storage.dart';
import 'package:conic/models/models.dart';
import 'package:conic/ui/pages/buy_coin/buy_coin.dart';
import 'package:conic/ui/pages/coin_detail/coin_detail.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SingleCoinHistory extends StatelessWidget {
  static const String route = "coin/detail/history";
  static String get routeRegEx => "coin/:id";
  final String id;
  final double price = 20.0;

  const SingleCoinHistory({
    Key? key,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<TransactionStorage>>(
      valueListenable:
          context.read<TransactionManager>().transactionStorageBox.listenable(),
      builder: (context, box, _) {
        final transactions = box.values.where((element) => element.id == id);

        if (transactions.isEmpty) {
          return Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          );
        }
        final item = transactions.first;
        final name = item.name;
        final symbol = item.symbol;
        final image = item.image;
        final count = transactions
            .map((e) => e.count)
            .reduce((value, element) => value + element);
        final data =
            context.read<TransactionManager>().portfolioStorageBox.get(id);
        // transactions.toList().sort((a, b) => a.time.compareTo(b.time));
        return SafeArea(
          bottom: true,
          top: false,
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(),
              actions: [
                CupertinoButton(
                  child: Icon(
                    Icons.add_circle_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      BuyCoin.route,
                      arguments: id,
                    );
                  },
                )
              ],
            ),
            body: ListView(
              padding: const EdgeInsets.all(12.0),
              children: [
                Row(
                  children: [
                    Image.network(
                      image,
                      width: 36,
                      height: 36,
                    ),
                    SizedBox(width: 16),
                    Text(
                      '$name ($symbol)',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${count * price}\$"),
                    if (data != null)
                      ChangeShow(
                        change: count * price - data.price,
                      )
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  '$count $symbol',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      CoinDetail.route,
                      arguments: id,
                    );
                  },
                  child: Text("Check Detail"),
                ),
                SizedBox(height: 24),
                Text(
                  'Transactions',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Type',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      'Quantity',
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                Divider(),
                ...transactions.map(
                  (e) {
                    final isIn =
                        e.coinTransactionStatus == CoinTransactionStatus.Buy &&
                            (e.coinTransactionStatus ==
                                    CoinTransactionStatus.Transfer ||
                                e.transferStatus == TransferStatus.TransferIn);
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4),
                          leading: isIn
                              ? Icon(
                                  Icons.arrow_circle_down_outlined,
                                  color: Colors.green,
                                  size: 36,
                                )
                              : Icon(
                                  Icons.arrow_circle_up,
                                  color: Colors.red,
                                  size: 36,
                                ),
                          title: Container(
                            height: 24,
                            child: Text(e.coinTransactionStatus
                                .toString()
                                .split(".")[1]),
                          ),
                          subtitle: Text(
                            e.time.toIso8601String(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (e.coinTransactionStatus !=
                                  CoinTransactionStatus.Transfer)
                                Text("${e.price} \$"),
                              Text(
                                "${e.count} $symbol",
                                style: TextStyle(
                                  color: isIn ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 3,
                        )
                      ],
                    );
                  },
                ).toList()
              ],
            ),
            bottomNavigationBar: Container(
              height: 50,
              color: Colors.transparent,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      BuyCoin.route,
                      arguments: id,
                    );
                  },
                  child: Text("Add Transaction"),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
