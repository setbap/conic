import 'package:conic/ui/pages/add_transaction/add_transaction.dart';
import 'package:conic/ui/pages/portfolio/widgets/widgets.dart';
import 'package:conic/ui/shared_widgets/shared_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yeet/yeet.dart';

class Portfolio extends StatefulWidget {
  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  ScrollController controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        PortfolioAppBar(
          controller: controller,
        ),
        PriceChange(),
        SliverChartBox(),
        PortfollioTableHeader(),
        SliverToBoxAdapter(
            child: Divider(
          thickness: 3,
        )),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, index) => PortfolioTableDataRow(),
            childCount: 5,
          ),
        ),
        SliverToBoxAdapter(
          child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "Add Transaction",
                style: TextStyle(color: Colors.white),
              ),
            ),
            onPressed: () {
              context.yeet(AddTransaction.route());
            },
          ),
        ),
        SliverPadding(padding: EdgeInsets.only(top: 100))
      ],
    );
  }
}
