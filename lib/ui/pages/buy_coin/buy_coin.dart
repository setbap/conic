import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/utils/colors.dart';
import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class BuyCoin extends StatefulWidget {
  static String route({required String id}) => "/add_transaction/$id";
  static String get routeRegEx => "/add_transaction/:id";

  final String coinId;

  const BuyCoin({Key? key, required this.coinId}) : super(key: key);

  @override
  _BuyCoinState createState() => _BuyCoinState();
}

class _BuyCoinState extends State<BuyCoin> {
  final String coinSymbol = "ADA";
  int segmentedControlValue = 0;

  final double price = 1.23;

  @override
  void initState() {
    super.initState();
    context.read<BuyPagePageDataCubit>().getBuyCoinData(coinId: widget.coinId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyPagePageDataCubit,
        GenericPageStete<BuyPageDataModel>>(
      listenWhen: (previous, current) {
        return !previous.isError && current.isError;
      },
      buildWhen: (previous, current) {
        return !previous.isLoading == current.isLoading;
      },
      listener: (context, state) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text(
              'Error',
              style: TextStyle(color: Colors.red),
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
                      .read<BuyPagePageDataCubit>()
                      .getBuyCoinData(coinId: widget.coinId);
                  Navigator.pop(context);
                },
                child: Text(
                  'retry',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 2,
            centerTitle: true,
            title: Text(
              "Add Transaction",
            ),
            bottom: PreferredSize(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: CupertinoSlidingSegmentedControl(
                          children: const <int, Widget>{
                            0: Text('Buy', style: TextStyle()),
                            1: Text('Sell'),
                            2: Text('Transfer')
                          },
                          thumbColor: Colors.black,
                          backgroundColor: DarkPrimaryColor,
                          groupValue: segmentedControlValue,
                          onValueChanged: (int? value) {
                            if (value != null) {
                              setState(() {
                                segmentedControlValue = value;
                              });
                            }
                          }),
                    ),
                  )
                ],
              ),
              preferredSize: Size(double.infinity, 48),
            ),
          ),
          body: LoadingShimmer(
            loading: state.isLoading,
            error: false,
            loadingWidget: BuyAndSellLoading(),
            dataWidget: SingleChildScrollView(child: BuyAndSell()),
          ),
        );
      },
    );
  }
}

class BuyAndSell extends StatelessWidget {
  final inputOutLinedBorder = OutlineInputBorder(
    borderSide: BorderSide(color: DarkPrimaryColor, width: 3),
    borderRadius: BorderRadius.circular(8),
  );

  final inlineInputDecoration = InputDecoration(
    fillColor: DarkForeground,
    filled: true,
    hintText: "0.00",
    border: OutlineInputBorder(
      borderSide: BorderSide(color: DarkPrimaryColor, width: 3),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: DarkPrimaryColor, width: 3),
      borderRadius: BorderRadius.circular(8),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<BuyPagePageDataCubit,
        GenericPageStete<BuyPageDataModel>>(
      builder: (context, state) => Container(
        padding: EdgeInsets.all(8),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: DarkForeground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      state.data?.image ?? "",
                      width: 28,
                      height: 28,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      state.data?.name ?? "",
                      style: textTheme.headline6,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      state.data?.symbol.toString() ?? "",
                      style: textTheme.bodyText1!
                          .copyWith(color: DarkTextForeground),
                    ),
                  ],
                ),
              ),
              Container(
                height: 105,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price Per Coin",
                              style: textTheme.bodyText1!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 60,
                              child: TextFormField(
                                initialValue:
                                    state.data?.price.toString() ?? "0",
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                validator: (value) {
                                  if (double.tryParse(value ?? "") == null) {
                                    return "wrong number";
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: inlineInputDecoration,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              child: Text(
                                "Quantity",
                                style: textTheme.bodyText1!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 60,
                              child: TextFormField(
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                validator: (value) {
                                  if (double.tryParse(value ?? "") == null) {
                                    return "wrong number";
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: inlineInputDecoration,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 105,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              child: Text(
                                "Fee",
                                style: textTheme.bodyText1!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 60,
                              child: TextFormField(
                                initialValue: '0',
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                validator: (value) {
                                  if (double.tryParse(value ?? "") == null) {
                                    return "wrong number";
                                  }
                                },
                                textAlign: TextAlign.left,
                                decoration: inlineInputDecoration,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20,
                              child: Text(
                                "Total Spent",
                                style: textTheme.bodyText1!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 48,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: DarkPrimaryColor,
                                    width: 2,
                                  ),
                                  color: DarkForeground,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${23.23} \$",
                                    style: textTheme.headline6,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.all(8),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    barrierDismissible: true,
                    barrierColor: DarkForeground.withAlpha(200),
                    builder: (context) {
                      return CupertinoTheme(
                        data: CupertinoThemeData(
                          brightness: Brightness.dark,
                          scaffoldBackgroundColor: Colors.red,
                        ),
                        child: Container(
                          height: 300,
                          color: Colors.white10,
                          child: CupertinoDatePicker(
                            initialDateTime: state.data?.time,
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
                    height: 48,
                    decoration: BoxDecoration(
                      color: DarkForeground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: DarkPrimaryColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: textTheme.bodyText1!.color,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        FittedBox(
                          child: Text(
                            '2020 , april 21 20:20',
                            style: textTheme.bodyText1,
                          ),
                        )
                      ],
                    )),
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
                    fillColor: DarkForeground,
                    enabledBorder: inputOutLinedBorder,
                    filled: true,
                    border: inputOutLinedBorder,
                    hintText: "Note on this transaction",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {},
                        child: Text(
                          "Buy",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
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
                height: 8,
              ),
            ],
          ),
        ),
      ),
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
                          Icon(
                            Icons.add,
                            size: 16,
                          ),
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
