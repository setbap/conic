import 'package:coingecko/coingecko.dart';
import 'package:conic/home.dart';
import 'package:conic/manager/manager.dart';
import 'package:conic/repositories/repositories.dart';
import 'package:conic/ui/pages/add_transaction/add_transaction.dart';
import 'package:conic/ui/pages/buy_coin/buy_coin.dart';
import 'package:conic/ui/pages/coin_detail/coin_detail.dart';
import 'package:conic/ui/pages/exchange_detail/exchange_detail.dart';
import 'package:conic/ui/pages/fiv_coins/fiv_coins.dart';
import 'package:conic/ui/pages/landing/landing.dart';
import 'package:conic/ui/pages/search/search.dart';
import 'package:conic/ui/pages/single_coin_history/single_coin_history.dart';
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
  Hive.registerAdapter<CoinTransactionStatus>(CoinTransactionStatusAdapter());
  await Hive.openBox<PortfolioStorage>(PortfolioStorage.PortfolioKey);
  await Hive.openBox<TransactionStorage>(TransactionStorage.TransactionKey);
  await Hive.openBox<String>(favKey);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      // enabled: false,
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
          RepositoryProvider<TransactionManager>(
            create: (context) => TransactionManager(),
          ),
          RepositoryProvider<FivManager>(
            create: (context) => FivManager(),
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
                transactionManager: context.read<TransactionManager>(),
                indexDataRepo: context.read<IndexDataRepository>(),
              ),
            ),
            BlocProvider<FivPageDataCubit>(
              create: (BuildContext context) => FivPageDataCubit(
                indexDataRepo: context.read<IndexDataRepository>(),
              ),
            ),
            BlocProvider<ExchangeDetailPageDataCubit>(
              create: (BuildContext context) => ExchangeDetailPageDataCubit(
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
          case FivCoins.route:
            return MaterialPageRoute(builder: (context) => FivCoins());
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

          case SingleCoinHistory.route:
            final String args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => SingleCoinHistory(
                id: args,
              ),
            );
          case ExchnageDetail.route:
            final String args = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => ExchnageDetail(
                id: args,
              ),
            );
        }
      },
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.orange.shade500,
          onPrimary: Colors.white,
          primaryVariant: Colors.yellow.shade200,
          secondary: Colors.grey.shade900,
          onSecondary: Colors.white,
          secondaryVariant: Colors.grey.shade600,
          surface: Colors.black,
          onSurface: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          error: Colors.red,
          onError: Colors.black,
        ),
        snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.grey.shade900,
            contentTextStyle: TextStyle(
              color: Colors.white,
            )),
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
          primaryColor: Colors.orange.shade500,
          brightness: Brightness.dark,
        ),
        hintColor: Colors.lightBlue.shade200,
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
    return Material(
      child: HomeTabBar(),
    );
  }
}
