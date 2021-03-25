import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndexNewsList extends StatelessWidget {
  const IndexNewsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) => NewsItem(
          title:
              'New crypto  could New crypto regulations could ld New crypto regulations could ',
          categoryName: "bitcoin",
          imgSrc:
              'https://u.today/sites/default/files/2019-12/Cryptocurrency%20News.jpg',
        ),
        childCount: 6,
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String title;
  final String imgSrc;
  final String categoryName;
  const NewsItem({
    Key? key,
    required this.title,
    required this.imgSrc,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {},
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
