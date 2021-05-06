import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';

import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class BuyAndSell extends StatefulWidget {
  final CoinTransactionStatus status;
  final BuyPageDataModel? data;

  const BuyAndSell({Key? key, required this.status, required this.data})
      : super(key: key);

  @override
  _BuyAndSellState createState() => _BuyAndSellState();
}

class _BuyAndSellState extends State<BuyAndSell> {
  final _formKey = GlobalKey<FormState>();
  final inputOutLinedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BuyPageDataModel? data;

  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<BuyPagePageDataCubit,
        GenericPageStete<BuyPageDataModel>>(
      builder: (context, state) => Container(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
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
                      style: textTheme.caption,
                    ),
                  ],
                ),
              ),
              Container(
                height: 105,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (widget.status != CoinTransactionStatus.Transfer)
                      Expanded(
                        key: ValueKey("Price Per Coin"),
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
                                  initialValue: state.data?.price.toString(),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9.]')),
                                  ],
                                  onChanged: (value) {
                                    if (double.tryParse(value) != null) {
                                      context
                                          .read<BuyPagePageDataCubit>()
                                          .updateBuyCoinData(
                                            data!.copyWith(
                                              price: double.tryParse(
                                                value,
                                              ),
                                            ),
                                          );
                                    }
                                  },
                                  validator: (value) {
                                    if (double.tryParse(value ?? "") == null) {
                                      return "wrong number";
                                    }
                                  },
                                  textAlign: TextAlign.left,
                                  decoration: InputDecoration(
                                    hintText: "0.00",
                                  ),
                                  maxLines: 1,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (widget.status == CoinTransactionStatus.Transfer)
                      Expanded(
                        key: ValueKey("TrasnferInOut"),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Trasnfer Mode",
                                style: textTheme.bodyText1!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Container(
                                height: 60,
                                child: DropdownButtonFormField<TransferStatus>(
                                  value: state.data?.transferType,
                                  onChanged: (value) {
                                    if (value != null) {
                                      context
                                          .read<BuyPagePageDataCubit>()
                                          .updateBuyCoinData(
                                            state.data!
                                                .copyWith(transferType: value),
                                          );
                                    }
                                  },
                                  dropdownColor: Theme.of(context).accentColor,
                                  decoration: InputDecoration(
                                    hintText: "0.00",
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Transfer In"),
                                      value: TransferStatus.TransferIn,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Transfer Out"),
                                      value: TransferStatus.TransferOut,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Expanded(
                      key: ValueKey("Quantity"),
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
                                onChanged: (value) {
                                  if (double.tryParse(value) != null) {
                                    context
                                        .read<BuyPagePageDataCubit>()
                                        .updateBuyCoinData(
                                          state.data!.copyWith(
                                            count: double.tryParse(value),
                                          ),
                                        );
                                  }
                                  if (value == "") {
                                    setState(() {
                                      context
                                          .read<BuyPagePageDataCubit>()
                                          .updateBuyCoinData(
                                            state.data!.copyWith(
                                              count: 0,
                                            ),
                                          );
                                    });
                                  }
                                },
                                initialValue: data?.count.toString(),
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return null;
                                  }
                                  if (double.tryParse(value) == null) {
                                    return "wrong number";
                                  }
                                },
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: "0.00",
                                ),
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
                                onChanged: (value) {
                                  if (double.tryParse(value) != null) {
                                    context
                                        .read<BuyPagePageDataCubit>()
                                        .updateBuyCoinData(
                                          state.data!.copyWith(
                                            fee: double.tryParse(value),
                                          ),
                                        );
                                  }

                                  if (value == "") {
                                    context
                                        .read<BuyPagePageDataCubit>()
                                        .updateBuyCoinData(
                                          state.data!.copyWith(
                                            fee: 0,
                                          ),
                                        );
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return null;
                                  }
                                  if (double.tryParse(value) == null) {
                                    return "wrong number";
                                  }
                                },
                                initialValue: state.data?.fee.toString(),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  hintText: "0.00",
                                ),
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.status != CoinTransactionStatus.Transfer)
                      Expanded(
                        key: ValueKey("total"),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 20,
                                child: Text(
                                  'Total ${widget.status == CoinTransactionStatus.Buy ? "Spent" : "Received"}',
                                  style: textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
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
                                      width: 2,
                                    ),
                                    color: Theme.of(context).accentColor,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${(state.data?.count ?? 0) * (state.data?.price ?? 0) - (state.data?.fee ?? 0)} \$",
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
                    builder: (context) {
                      return Container(
                        height: 300,
                        color: Theme.of(context).backgroundColor,
                        child: CupertinoTheme(
                          data: CupertinoThemeData(
                              brightness: Theme.of(context).brightness),
                          child: CupertinoDatePicker(
                            initialDateTime: state.data?.time,
                            onDateTimeChanged: (value) {
                              context
                                  .read<BuyPagePageDataCubit>()
                                  .updateBuyCoinData(
                                    state.data!.copyWith(
                                      time: value,
                                    ),
                                  );
                            },
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
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
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
                            '${state.data?.time.year}/${state.data?.time.month}/${state.data?.time.day}  \t ,  ${state.data?.time.hour}:${state.data?.time.minute}',
                            style: textTheme.bodyText1,
                          ),
                        )
                      ],
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withAlpha(40),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextFormField(
                  maxLines: 4,
                  initialValue: state.data?.desc,
                  onChanged: (value) {
                    context.read<BuyPagePageDataCubit>().updateBuyCoinData(
                          state.data!.copyWith(
                            desc: value,
                          ),
                        );
                  },
                  decoration: InputDecoration(
                    hintText: "Note on this transaction",
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
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
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<BuyPagePageDataCubit>().addTransaction(
                                  transactionStatus: widget.status,
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  " Please fill inputs correctly",
                                ),
                                backgroundColor: Theme.of(context).accentColor,
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Add Transaction",
                          style: TextStyle(color: Theme.of(context).cardColor),
                        ),
                      ),
                    ),
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
  const BuyAndSellLoading();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: shimmerBaseColor,
      highlightColor: shimmerHighlightColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxShimmer(height: 48, width: width / 2 - 40, radius: 12),
                BoxShimmer(height: 48, width: width / 2 - 40, radius: 12),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxShimmer(height: 48, width: width / 2 - 40, radius: 12),
                BoxShimmer(height: 48, width: width / 2 - 40, radius: 12),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxShimmer(height: 48, width: width / 2 - 40, radius: 12),
                BoxShimmer(height: 48, width: width / 2 - 40, radius: 12),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BoxShimmer(height: 150, width: double.infinity, radius: 16),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoxShimmer(height: 48, width: width - 40, radius: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
