import 'package:bloc/bloc.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/news_data_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'latest_news_state.dart';

class LatestNewsCubit extends Cubit<LatestNewsState> {
  final NewsDataRepo _newsDataRepo;
  LatestNewsCubit({
    required NewsDataRepo newsDataRepo,
  })   : _newsDataRepo = newsDataRepo,
        super(
          LatestNewsState(
            data: [],
            error: "",
            loading: true,
          ),
        );

  getNews() async {
    emit(state.copyWith(loading: true, error: ''));
    _newsDataRepo
        .getLatestNews(count: 6)
        .then((value) => {state.copyWith(data: value)})
        .catchError((err) => {state.copyWith(error: 'an error occured')})
        .whenComplete(() => emit(state.copyWith(loading: false)));
  }
}
