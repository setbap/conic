import 'package:conic/main.dart';
import 'package:conic/pages/add_transaction/add_transaction.dart';
import 'package:conic/pages/coin_detail/coin_detail.dart';
import 'package:conic/pages/search/search.dart';
import 'package:flutter/material.dart';
import 'package:yeet/yeet.dart';

final yeet = Yeet(
  children: [
    Yeet(
      path: Search.routeRegEx,
      builder: (_, __) => Search(),
    ),
    Yeet(
      path: CoinDetail.routeRegEx,
      builder: (params, __) => Scaffold(
        backgroundColor: Colors.black,
        body: CoinDetail(id: params['id']!),
      ),
    ),
    Yeet(
      path: AddTransaction.routeRegEx,
      builder: (params, __) => Scaffold(
        backgroundColor: Colors.black,
        body: AddTransaction(),
      ),
    ),
    Yeet(
      path: MyHomePage.routeRegEx,
      builder: (_, __) => MyHomePage(),
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
      builder: (_, __) => MyHomePage(),
    ),
  ],
);
