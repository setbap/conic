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
            isLoading: true,
          ),
        );

  getNews() async {
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _newsDataRepo.getLatestNews(count: 6).then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
