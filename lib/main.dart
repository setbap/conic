import 'package:conic/home.dart';
import 'package:conic/repositories/news_data_repository.dart';
import 'package:conic/routes.dart';
import 'package:cryptopanic/cryptopanic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:yeet/yeet.dart';
import 'package:path_provider/path_provider.dart';

import 'business_logic/latest_news_cubit/latest_news_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NewsDataRepo>(
          create: (context) => NewsDataRepo(newApi: CryptoPanicClient()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LatestNewsCubit>(
            create: (BuildContext context) => LatestNewsCubit(
              newsDataRepo: context.read<NewsDataRepo>(),
            )..getNews(),
          ),
        ],
        child: MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
