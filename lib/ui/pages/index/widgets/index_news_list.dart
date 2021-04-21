import 'package:conic/utils/utils.dart';
import 'package:cryptopanic/cryptopanic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class IndexNewsList extends StatelessWidget {
  final bool isLoading;
  final List<NewsModel> data;
  const IndexNewsList({
    Key? key,
    required this.isLoading,
    this.data = const <NewsModel>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingShimmer(
      loading: isLoading,
      error: false,
      loadingWidget: SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, index) => NewsItemLoading(),
          childCount: 6,
        ),
      ),
      dataWidget: SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, index) => LoadingShimmer(
            loadingWidget: NewsItemLoading(),
            error: false,
            loading: isLoading,
            dataWidget: NewsItemData(
              onPressed: () async {
                final _url = data[index].url;
                await canLaunch(_url)
                    ? await launch(_url)
                    : throw 'Could not launch $_url';
              },
              title: data[index].title,
              categoryName: data[index].domain,
              imgSrc:
                  'https://u.today/sites/default/files/2019-12/Cryptocurrency%20News.jpg',
            ),
          ),
          childCount: data.length,
        ),
      ),
    );
  }
}

class NewsItemData extends StatelessWidget {
  final String title;
  final String imgSrc;
  final String categoryName;
  final VoidCallback? onPressed;
  const NewsItemData(
      {Key? key,
      required this.title,
      required this.imgSrc,
      required this.categoryName,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imgSrc,
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => Placeholder(
                    fallbackWidth: 50,
                    fallbackHeight: 50,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    SizedBox(height: 4),
                    Text(
                      categoryName,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 10),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewsItemLoading extends StatelessWidget {
  const NewsItemLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Shimmer.fromColors(
          baseColor: shimmerBaseColor,
          highlightColor: shimmerHighlightColor,
          child: Container(
            child: Row(
              children: [
                CircleShimmer(radius: 28),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoxShimmer(
                          height: 20, width: double.infinity - 4, radius: 4),
                      SizedBox(height: 4),
                      BoxShimmer(height: 16, width: 40, radius: 4),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
