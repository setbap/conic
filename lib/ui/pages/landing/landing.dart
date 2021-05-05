import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/main.dart';
import 'package:conic/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Landing extends StatefulWidget {
  static const route = "/loading";
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchPageDataCubit, GenericPageStete<SearchData>>(
      listener: (context, state) {
        if (!state.isLoading) {
          Navigator.pushReplacementNamed(context, MyHomePage.route);
        }
      },
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
