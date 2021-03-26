
import 'package:conic/shared_widgets/shared_widgets.dart';
import 'package:conic/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PortfolioTableDataRow extends StatelessWidget {
  final String imageSrc;
  final String name;
  final String id;
  final double price;
  final double coinCount;
  final double change;
  final VoidCallback onPress;
  const PortfolioTableDataRow({
    Key? key,
    required this.name,
    required this.imageSrc,
    required this.id,
    required this.price,
    required this.coinCount,
    required this.change,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPress,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Container(
                      child: CircleAvatar(
                        child: Image.network(
                          imageSrc,
                          height: 32,
                          width: 32,
                          errorBuilder: (_, __, ___) =>
                              Container(color: Colors.yellow),
                        ),
                      ),
                      height: 48,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          id,
                          style: TextStyle(
                              fontSize: 12, color: DarkTextForeground),
                          textAlign: TextAlign.start,
                        )
                      ],
                    )
                  ],
                ),
                flex: 2,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      price.toStringAsFixed(4),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    ChangeShow(
                      change: change,
                      mainAxisAlignment: MainAxisAlignment.center,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (price*coinCount).toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        '$coinCount $id',
                        style: TextStyle(
                          fontSize: 12,
                          color: DarkTextForeground,
                        ),
                        textAlign: TextAlign.end,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}

class PortfollioTableHeader extends StatelessWidget {
  const PortfollioTableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Text(
                "Asset",
                textAlign: TextAlign.left,
              ),
            ),
            flex: 2,
          ),
          Expanded(
              child: Text(
                "Price",
                textAlign: TextAlign.center,
              )),
          Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 8),
                child: Text(
                  "Holdings",
                  textAlign: TextAlign.end,
                ),
              )),
        ],
      ),
    );
  }
}
