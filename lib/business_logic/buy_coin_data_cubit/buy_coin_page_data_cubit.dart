import 'package:bloc/bloc.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';

class BuyPagePageDataCubit extends Cubit<GenericPageStete<BuyPageDataModel>> {
  final IndexDataRepository _indexDataRepo;
  BuyPagePageDataCubit({
    required IndexDataRepository indexDataRepo,
  })  : _indexDataRepo = indexDataRepo,
        super(
          GenericPageStete<BuyPageDataModel>(
            error: "",
            isLoading: true,
          ),
        );

  getPortfolioData({required String coinId}) async {
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _indexDataRepo.getBuyPageInfo(coinId).then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
