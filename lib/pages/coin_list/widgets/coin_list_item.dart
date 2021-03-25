import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinListItem extends StatelessWidget {
  final String imageSrc;
  final String name;
  final String chartSrc;
  final double price;
  final int rank;
  final String id;
  final double change;
  final double marketCap;

  const CoinListItem({
    Key? key,
    required this.imageSrc,
    required this.name,
    required this.chartSrc,
    required this.price,
    required this.rank,
    required this.id,
    required this.change,
    required this.marketCap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 20,
              child: Image.network(
                imageSrc,
                errorBuilder: (context, error, stackTrace) => Placeholder(),
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                  Image.network(
                    chartSrc,
                    height: 24,
                    color: Colors.green,
                    errorBuilder: (context, error, stackTrace) => Container(
                      child: Text(
                        "error in connection",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(),
                  Text(
                    "$price\$",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text(
                          '$rank',
                          style: TextStyle(fontSize: 10),
                        ),
                        decoration: BoxDecoration(
                          color: DarkPrimaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 10,
                        ),
                        margin: EdgeInsets.only(
                          right: 6,
                        ),
                      ),
                      Text(
                        id,
                        style:
                            TextStyle(fontSize: 12, color: DarkTextForeground),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      ChangeShow(change: change)
                    ],
                  ),
                  Text(
                    'MCap $marketCap ',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12, color: DarkTextForeground),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ],
          )),
          Container(
            child: CupertinoButton(
              padding: const EdgeInsets.all(2),
              onPressed: () {},
              child: Icon(
                Icons.star_border_outlined,
                color: Colors.yellow,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
