import 'package:coingecko/coingecko.dart';
import 'package:conic/home.dart';
import 'package:conic/manager/transaction_storage.dart';
import 'package:conic/repositories/repositories.dart';
import 'package:conic/routes.dart';
import 'package:cryptopanic/cryptopanic.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:yeet/yeet.dart';
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
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<IndexPageDataCubit>(
              create: (BuildContext context) => IndexPageDataCubit(
                indexDataRepo: context.read<IndexDataRepository>(),
              )..getIndexData(),
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
    return MaterialApp.router(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      routeInformationParser: YeetInformationParser(),
      routerDelegate: YeeterDelegate(yeet: yeet),
      title: 'Conic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.red,
          secondary: Colors.green,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String route() => "/";
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
