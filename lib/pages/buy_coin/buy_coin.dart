import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class BuyCoin extends StatelessWidget {


  static String route({required String id}) => "/buy/$id";
  static String get routeRegEx => "/buy/:id";

  final String coinId;
  final String coinSymbol = "ADA";
  final double price = 1.23;

  const BuyCoin({Key? key,required this.coinId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      // length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Icon(Icons.monetization_on_outlined),
              ),
              SizedBox(
                width: 16,
              ),
              Text(coinId),
              SizedBox(
                width: 16,
              ),
              Text(coinSymbol),
            ],
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Center(child: Tab(child: Text("Buy And Sell"))),
              // Center(child: Tab(child: Text("Change"))),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: TabBarView(
          children: [
            SingleChildScrollView(child: BuyAndSellLoading()),
            // Text("Change"),
          ],
        ),
      ),
    );
  }
}

class BuyAndSell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Token"),
              Container(
                height: 36,
                width: 56,
                child: TextFormField(
                  readOnly: true,
                  initialValue: 12.1.toString(),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    focusColor: Colors.white10,
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: EdgeInsets.all(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Price"),
              Container(
                height: 36,
                width: 56,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  initialValue: 12.1.toString(),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(4)),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Token Count"),
              Container(
                height: 36,
                width: 56,
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  initialValue: 12.1.toString(),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(4)),
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return CupertinoTheme(
                  data: CupertinoThemeData(brightness: Brightness.dark),
                  child: Container(
                    height: 300,
                    color: Colors.black54,
                    child: CupertinoDatePicker(
                      onDateTimeChanged: (value) {},
                      backgroundColor: Colors.black,
                      maximumDate: DateTime.now().add(
                        Duration(
                          seconds: 20,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date Time"),
                Text(DateTime.now().toString()),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Transaction Mode"),
              CupertinoSwitch(
                value: false,
                onChanged: (value) {},
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade900.withAlpha(40),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            maxLines: 4,
            decoration: InputDecoration(
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                hintText: "Note on this transaction"),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Divider(),
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: Container(),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(" "),
                        Text("23.2"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    Row(
                      children: [
                        Text("+"),
                        Text("23,2"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(" "),
                        Text("23,20000"),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: OutlinedButton(
                  style:
                  OutlinedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {},
                  child: Text(
                    "Buy",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Sell",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 70,
        ),
      ],
    );
  }
}

class BuyAndSellLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxShimmer(height: 20, width: 40, radius: 4),
                BoxShimmer(height: 20, width: 40, radius: 4),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxShimmer(height: 20, width: 48, radius: 4),
                BoxShimmer(height: 20, width: 64, radius: 4),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxShimmer(height: 20, width: 36, radius: 4),
                BoxShimmer(height: 20, width: 48, radius: 4),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxShimmer(height: 20, width: 40, radius: 4),
                BoxShimmer(height: 20, width: 40, radius: 4),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BoxShimmer(height: 150, width: double.infinity, radius: 16),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: Container(),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(" "),
                          BoxShimmer(height: 20, width: 40, radius: 4),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(Icons.add,size: 16,),
                          BoxShimmer(height: 20, width: 36, radius: 4),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text(" "),
                          BoxShimmer(height: 20, width: 56, radius: 4),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: BoxShimmer(
                    height: 32,
                    width: double.infinity,
                    radius: 6,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: BoxShimmer(
                    height: 32,
                    width: double.infinity,
                    radius: 6,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }
}
