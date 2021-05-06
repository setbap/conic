import 'package:coingecko/coingecko.dart';
import 'package:conic/home.dart';
import 'package:conic/manager/transaction_storage.dart';
import 'package:conic/repositories/repositories.dart';
import 'package:conic/ui/pages/add_transaction/add_transaction.dart';
import 'package:conic/ui/pages/buy_coin/buy_coin.dart';
import 'package:conic/ui/pages/coin_detail/coin_detail.dart';
import 'package:conic/ui/pages/landing/landing.dart';
import 'package:conic/ui/pages/search/search.dart';

import 'package:cryptopanic/cryptopanic.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'business_logic/business_logic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:conic/models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter<PortfolioStorage>(PortfolioStorageAdapter());
  Hive.registerAdapter<TransactionStorage>(TransactionStorageAdapter());
  Hive.registerAdapter<TransferStatus>(TransferStatusAdapter());
  await Hive.openBox<PortfolioStorage>(PortfolioStorage.PortfolioKey);
  await Hive.openBox<TransactionStorage>(TransactionStorage.TransactionKey);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IndexDataRepository>(
            create: (context) => IndexDataRepository(
              newApi: CryptoPanicClient(),
              coinApi: CoinGeckoClient(),
            ),
          ),
          RepositoryProvider<ParsDataRepo>(
            create: (context) => ParsDataRepo(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<IndexPageDataCubit>(
              create: (BuildContext context) => IndexPageDataCubit(
                indexDataRepo: context.read<IndexDataRepository>(),
              )..getIndexData(),
            ),
            BlocProvider<SearchPageDataCubit>(
              create: (BuildContext context) => SearchPageDataCubit(
                parsDataRepo: context.read<ParsDataRepo>(),
              )..getListData(),
            ),
            BlocProvider<ListPageDataCubit>(
              create: (BuildContext context) => ListPageDataCubit(
                indexDataRepo: context.read<IndexDataRepository>(),
              )..getListData(),
            ),
            BlocProvider<CoinDetailPageDataCubit>(
              create: (BuildContext context) => CoinDetailPageDataCubit(
                indexDataRepo: context.read<IndexDataRepository>(),
              ),
            ),
            BlocProvider<CoinNewsPageDataCubit>(
              create: (BuildContext context) => CoinNewsPageDataCubit(
                indexDataRepo: context.read<IndexDataRepository>(),
              ),
            ),
            BlocProvider<PortfolioPageDataCubit>(
              create: (BuildContext context) => PortfolioPageDataCubit(
                indexDataRepo: context.read<IndexDataRepository>(),
              ),
            ),
            BlocProvider<BuyPagePageDataCubit>(
              create: (BuildContext context) => BuyPagePageDataCubit(
                transactionManager: TransactionManager(),
                indexDataRepo: context.read<IndexDataRepository>(),
              ),
            ),
          ],
          child: MyApp(),
        ),
      ), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      title: 'Conic',
      debugShowCheckedModeBanner: false,
      initialRoute: Landing.route,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Landing.route:
            return MaterialPageRoute(builder: (context) => Landing());
          case MyHomePage.route:
            return MaterialPageRoute(builder: (context) => MyHomePage());
          case AddTransaction.route:
            return MaterialPageRoute(builder: (context) => AddTransaction());
          case Search.route:
            return MaterialPageRoute(builder: (context) => Search());
          case BuyCoin.route:
            final String args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => BuyCoin(
                coinId: args,
              ),
            );
          case CoinDetail.route:
            final String args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => CoinDetail(
                id: args,
              ),
            );
        }
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.grey.shade900,
        primaryColor: Colors.red,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
        ),
        chipTheme: ChipThemeData.fromDefaults(
          primaryColor: Color(0xff222431),
          labelStyle: TextStyle(),
          secondaryColor: Colors.grey.shade900,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Colors.green,
        )),
        cardColor: Colors.white,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: Colors.red,
          brightness: Brightness.dark,
        ),
        buttonColor: Colors.red,
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.grey.shade900,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
            )),
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          caption: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String route = "/";
  static String get routeRegEx => "/";
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeTabBar(),
    );
  }
}
