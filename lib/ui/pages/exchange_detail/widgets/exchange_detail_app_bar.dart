import 'package:conic/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:number_display/number_display.dart';

class ExchangeDetailAppBar extends StatefulWidget {
  final ScrollController controller;

  final String name;
  final String imageSrc;
  const ExchangeDetailAppBar({
    Key? key,
    required this.name,
    required this.imageSrc,
    required this.controller,
  }) : super(key: key);

  @override
  _ExchangeDetailAppBarState createState() => _ExchangeDetailAppBarState();
}

class _ExchangeDetailAppBarState extends State<ExchangeDetailAppBar> {
  double textOpacity = 0;
  bool isPageClosed = false;
  var numberDisply = createDisplay(length: 8);
  @override
  void dispose() {
    isPageClosed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final offset = widget.controller.offset;
      if (!isPageClosed) {
        if (offset > 0 && offset < 130) {
          setState(() {
            setState(() {});
            textOpacity = (offset.clamp(30, 130) - 30) / 100;
          });
        } else if (offset < 0 && textOpacity != 0) {
          //when scroll so fast
          setState(() {
            textOpacity = 0;
          });
        } else if (offset > 130 && textOpacity != 1) {
          setState(() {
            textOpacity = 1;
          });
        }
        //when scroll so fast

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: BackButton(),
      pinned: true,
      centerTitle: true,
      title: Transform.translate(
        offset: Offset(0, (50 - (textOpacity * 50)).clamp(0, 50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.network(
                widget.imageSrc,
              ),
              radius: 16,
            ),
            Opacity(
              opacity: textOpacity,
              child: Row(
                children: [
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "${widget.name}",
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExchangeDetailAppBarLoading extends StatelessWidget {
  const ExchangeDetailAppBarLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: BackButton(),
      pinned: true,
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.star_outline))],
      title: MyShimmer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BoxShimmer(height: 20, width: 40, radius: 4),
            SizedBox(
              width: 8,
            ),
            CircleShimmer(radius: 32),
            SizedBox(
              width: 8,
            ),
            BoxShimmer(height: 20, width: 40, radius: 4),
          ],
        ),
      ),
    );
  }
}
