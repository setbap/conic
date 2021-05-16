import 'package:bloc/bloc.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';

class ExchangeDetailPageDataCubit
    extends Cubit<GenericPageStete<ExchangeDetailPageDataModel>> {
  final IndexDataRepository _indexDataRepo;
  ExchangeDetailPageDataCubit({
    required IndexDataRepository indexDataRepo,
  })  : _indexDataRepo = indexDataRepo,
        super(
          GenericPageStete<ExchangeDetailPageDataModel>(
            error: "",
            isLoading: true,
          ),
        );

  getExchangeDetailData(String exchangeId) async {
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _indexDataRepo.getExchangeDetaiPageInfo(exchangeId).then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      print(err);
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
