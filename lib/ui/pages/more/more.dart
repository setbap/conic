import 'package:conic/manager/transaction_storage.dart';
import 'package:conic/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class More extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ValueListenableBuilder<Box<TransactionStorage>>(
        valueListenable:
            TransactionManager().transactionStorageBox.listenable(),
        builder: (context, box, child) {
          final values = box.values.toList().reversed.toList();
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                title: Text("Conic"),
                pinned: true,
                bottom: AppBar(
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: CupertinoButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.golf_course,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: CupertinoButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.golf_course,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: CupertinoButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.golf_course,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: CupertinoButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(4),
                          child: Icon(
                            Icons.golf_course,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) => ListTile(
                    title: Text(
                        "${values[index].id} | ${values[index].count} | ${values[index].price} | ${values[index].desc}"),
                  ),
                  childCount: values.length,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
