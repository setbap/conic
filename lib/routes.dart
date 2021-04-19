import 'package:conic/main.dart';
import 'package:conic/ui/pages/add_transaction/add_transaction.dart';
import 'package:conic/ui/pages/buy_coin/buy_coin.dart';
import 'package:conic/ui/pages/coin_detail/coin_detail.dart';
import 'package:conic/ui/pages/search/search.dart';
import 'package:flutter/material.dart';
import 'package:yeet/yeet.dart';

final yeet = Yeet(
  children: [
    Yeet(
      path: Search.routeRegEx,
      builder: (context) => Search(),
      children: [
        Yeet(
          path: CoinDetail.routeRegEx,
          builder: (context) => Scaffold(
            backgroundColor: Colors.black,
            body: CoinDetail(id: context.params['id']!),
          ),
        )
      ],
    ),
    Yeet(
      path: BuyCoin.routeRegEx,
      builder: (context) => BuyCoin(coinId: context.params["id"]!),
    ),
    // Yeet(
    //     path: CoinDetail.routeRegEx,
    //     builder: (context) => Scaffold(
    //           backgroundColor: Colors.black,
    //           body: CoinDetail(id: context.params['id']!),
    //         ),
    //     children: [
    //       Yeet(
    //         path: CoinDetail.routeRegEx,
    //         builder: (context) => Scaffold(
    //           backgroundColor: Colors.black,
    //           body: CoinDetail(id: context.params['id']!),
    //         ),
    //       )
    //     ]),
    Yeet(
      path: AddTransaction.routeRegEx,
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        body: AddTransaction(),
      ),
    ),
    Yeet(
      path: MyHomePage.routeRegEx,
      builder: (context) => MyHomePage(),
      children: [
        Yeet(
          path: CoinDetail.routeRegEx,
          builder: (context) => Scaffold(
            backgroundColor: Colors.black,
            body: CoinDetail(id: context.params['id']!),
          ),
        )
      ],
    ),

    // Yeet.custom(
    //   path: r'/user/:id(\d+)',
    //   builder: (params, _) => UserView(int.parse(params['id']!)),
    //   transitionsBuilder: (context, animation, secondaryAnimation, child) =>
    //       FadeTransition(
    //         opacity: animation,
    //         child: child,
    //       ),
    //   children: [
    //     Yeet(
    //       path: 'posts',
    //       builder: (params, _) => PostsView(int.parse(params['id']!)),
    //     )
    //   ],
    // ),
    Yeet(
      path: ':_(.*)',
      builder: (context) => MyHomePage(),
    ),
  ],
);
