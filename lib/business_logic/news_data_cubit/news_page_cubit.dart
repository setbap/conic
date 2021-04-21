import 'package:bloc/bloc.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';

class CoinNewsPageDataCubit extends Cubit<GenericPageStete<NewsPageDataModel>> {
  final IndexDataRepository _indexDataRepo;
  CoinNewsPageDataCubit({
    required IndexDataRepository indexDataRepo,
  })  : _indexDataRepo = indexDataRepo,
        super(
          GenericPageStete<NewsPageDataModel>(
            error: "",
            isLoading: true,
          ),
        );

  getCoinDetailData({required NewsFilter newsFilter}) async {
    if (state.data?.getValueFromFilter(newsFilter) != null) {
      emit(
        state.copyWith(data: state.data?.copyWith(newsFilter: newsFilter)),
      );
      return;
    }
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _indexDataRepo.getNewsPageInfo(newsFilter).then((value) {
      if (state.data == null) {
        final dataState = NewsPageDataModel(newsFilter: newsFilter);
        emit(
          state.copyWith(
            data: dataState.copyWithNewsFilter(newsFilter, value),
          ),
        );
      } else {
        emit(
          state.copyWith(
            data: state.data!.copyWithNewsFilter(newsFilter, value),
          ),
        );
      }
    }).catchError((err) {
      print(err);
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
