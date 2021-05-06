import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/ui/pages/index/widgets/widgets.dart';
import 'package:conic/ui/pages/news/widgest/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    super.initState();
    context
        .read<CoinNewsPageDataCubit>()
        .getCoinDetailData(newsFilter: NewsFilter.rising);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoinNewsPageDataCubit,
        GenericPageStete<NewsPageDataModel>>(
      listenWhen: (previous, current) {
        return !previous.isError && current.isError;
      },
      listener: (context, state) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(
              'Error',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            content: Text('an Error with you connection'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('dismiss'),
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<CoinNewsPageDataCubit>()
                      .getCoinDetailData(newsFilter: state.data!.newsFilter);
                  Navigator.pop(context);
                },
                child: Text(
                  'retry',
                  style: TextStyle(color: Theme.of(context).cardColor),
                ),
              ),
            ],
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Builder(
            builder: (context) {
              final filterType =
                  state.data?.newsFilter.toString().split(".")[1].toUpperCase();
              return CustomScrollView(
                slivers: [
                  NewsAppBarSliver(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return NewsChip(
                          isActive: state.data?.newsFilter ==
                              NewsFilter.values[index],
                          onPress: () {
                            context
                                .read<CoinNewsPageDataCubit>()
                                .getCoinDetailData(
                                    newsFilter: NewsFilter.values[index]);
                          },
                          text: NewsFilter.values[index]
                              .toString()
                              .split(".")[1]
                              .toUpperCase(),
                        );
                      },
                      itemCount: NewsFilter.values.length,
                    ),
                  ),
                  BoxTextTitle(
                    title: "$filterType News",
                    subTitle: "Last News about $filterType Coins",
                  ),
                  IndexNewsList(
                    data: state.data
                            ?.getValueFromFilter(state.data!.newsFilter)
                            ?.results ??
                        [],
                    isLoading: state.isLoading || state.isError,
                  ),
                  SliverPadding(padding: EdgeInsets.all(44)),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
