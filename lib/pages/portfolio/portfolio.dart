import 'dart:math';

import 'package:conic/shared_widgets/change_shower.dart';
import 'package:conic/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Portfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        pinned: true,
        backgroundColor: Colors.black,
        title: Text(
          "\$ 432.23",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        actions: [
          CupertinoButton(
            child: Icon(
              Icons.add_circle_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      SliverToBoxAdapter(
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                child: Text(
                  "Asset",
                  textAlign: TextAlign.left,
                ),
              ),
              flex: 2,
            ),
            Expanded(
                child: Text(
              "Price",
              textAlign: TextAlign.center,
            )),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(right: 8),
              child: Text(
                "Holdings",
                textAlign: TextAlign.end,
              ),
            )),
          ],
        ),
      ),
      SliverToBoxAdapter(
          child: Divider(
        thickness: 3,
      )),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, index) => CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 6,
                          ),
                          Container(
                            child: CircleAvatar(
                              child: Image.network(
                                'https://s2.coinmarketcap.com/static/img/coins/64x64/1.png',
                                height: 32,
                                width: 32,
                                errorBuilder: (_, __, ___) =>
                                    Container(color: Colors.yellow),
                              ),
                            ),
                            height: 48,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Cardano",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Ada",
                                style: TextStyle(
                                    fontSize: 12, color: DarkTextForeground),
                                textAlign: TextAlign.start,
                              )
                            ],
                          )
                        ],
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "\$132.12",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Center(
                            child: ChangeShow(
                              change: Random().nextDouble() - 0.5,
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "\$132.12",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              "123 ADA",
                              style: TextStyle(
                                fontSize: 12,
                                color: DarkTextForeground,
                              ),
                              textAlign: TextAlign.end,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                )
              ],
            ),
          ),
          childCount: 5,
        ),
      )
    ]);
  }
}
