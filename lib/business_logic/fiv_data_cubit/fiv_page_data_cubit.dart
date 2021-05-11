import 'package:bloc/bloc.dart';
import 'package:coingecko/coingecko.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/repositories/repositories.dart';

class FivPageDataCubit extends Cubit<GenericPageStete<List<TopCoin>>> {
  final IndexDataRepository _indexDataRepo;
  FivPageDataCubit({
    required IndexDataRepository indexDataRepo,
  })  : _indexDataRepo = indexDataRepo,
        super(
          GenericPageStete<List<TopCoin>>(
            error: "",
            isLoading: true,
          ),
        );

  void getFivCoinsData({required List<String> coinsId}) async {
    if (coinsId.length == 0) {
      emit(
        state.copyWith(isLoading: false, isError: false, error: '', data: []),
      );
      return null;
    }
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _indexDataRepo.getFivInfo(coins: coinsId).then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }

  void deleteFivCoinData({required String coinId}) async {
    if (state.data != null) {
      state.data!.removeWhere((element) => element.id == coinId);
      emit(state);
    }
  }
}
