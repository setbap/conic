import 'package:bloc/bloc.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';

class SearchPageDataCubit extends Cubit<GenericPageStete<SearchData>> {
  final ParsDataRepo _parsDataRepo;
  SearchPageDataCubit({
    required ParsDataRepo parsDataRepo,
  })  : _parsDataRepo = parsDataRepo,
        super(
          GenericPageStete<SearchData>(
            error: "",
            isLoading: true,
          ),
        );

  getListData() async {
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    Future.wait([
      _parsDataRepo.fetchCoins(),
      _parsDataRepo.fetchExchanges(),
    ]).then((data) {
      emit(
        state.copyWith(
          data: SearchData(
            simpleCoins: data[0] as List<SimpleCoin>,
            simpleExchanges: data[1] as List<SimpleExchange>,
          ),
        ),
      );
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
