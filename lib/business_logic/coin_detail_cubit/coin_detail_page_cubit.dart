import 'package:bloc/bloc.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';

class CoinDetailPageDataCubit
    extends Cubit<GenericPageStete<CoinDetailPageDataModel>> {
  final IndexDataRepository _indexDataRepo;
  CoinDetailPageDataCubit({
    required IndexDataRepository indexDataRepo,
  })  : _indexDataRepo = indexDataRepo,
        super(
          GenericPageStete<CoinDetailPageDataModel>(
            error: "",
            isLoading: true,
          ),
        );

  getCoinDetailData(String coinName) async {
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _indexDataRepo.getCoinDetaiPageInfo(coinName).then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      print(err);
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
