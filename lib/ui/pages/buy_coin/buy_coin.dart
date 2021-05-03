import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/ui/pages/buy_coin/widgets/widgets.dart';
import 'package:conic/utils/colors.dart';
import 'package:conic/utils/shimmer_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyCoin extends StatefulWidget {
  static String route({required String id}) => "/add_transaction/$id";
  static String get routeRegEx => "/add_transaction/:id";

  final String coinId;

  const BuyCoin({Key? key, required this.coinId}) : super(key: key);

  @override
  _BuyCoinState createState() => _BuyCoinState();
}

class _BuyCoinState extends State<BuyCoin> {
  CoinTransactionStatus segmentedControlValue = CoinTransactionStatus.Buy;

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
                          children: const <CoinTransactionStatus, Widget>{
                            CoinTransactionStatus.Buy: Text('Buy'),
                            CoinTransactionStatus.Sell: Text('Sell'),
                            CoinTransactionStatus.Transfer: Text('Transfer')
                          },
                          thumbColor: Colors.black,
                          backgroundColor: DarkPrimaryColor,
                          groupValue: segmentedControlValue,
                          onValueChanged: (CoinTransactionStatus? value) {
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
              preferredSize: const Size(double.infinity, 48),
            ),
          ),
          body: LoadingShimmer(
            loading: state.isLoading,
            error: false,
            loadingWidget: const BuyAndSellLoading(),
            dataWidget: SingleChildScrollView(
              child: BuyAndSell(
                status: segmentedControlValue,
                data: state.data,
              ),
            ),
          ),
        );
      },
    );
  }
}
