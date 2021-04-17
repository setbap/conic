import 'package:bloc/bloc.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

part 'index_page_data_state.dart';

class IndexPageDataCubit extends Cubit<IndexPageDataState> {
  final IndexDataRepository _indexDataRepo;
  IndexPageDataCubit({
    required IndexDataRepository indexDataRepo,
  })  : _indexDataRepo = indexDataRepo,
        super(
          IndexPageDataState(
            error: "",
            isLoading: true,
          ),
        );

  getIndexData() async {
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _indexDataRepo.getIndexPageInfo().then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
