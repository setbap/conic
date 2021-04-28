import 'package:bloc/bloc.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';

class PortfolioPageDataCubit
    extends Cubit<GenericPageStete<PortfolioPageDataModel>> {
  final IndexDataRepository _indexDataRepo;
  PortfolioPageDataCubit({
    required IndexDataRepository indexDataRepo,
  })  : _indexDataRepo = indexDataRepo,
        super(
          GenericPageStete<PortfolioPageDataModel>(
            error: "",
            isLoading: true,
          ),
        );

  getPortfolioData(
      {required Map<String, PortfolioStorage> portfolioItems}) async {
    emit(
      state.copyWith(
        isLoading: true,
        isError: false,
        error: '',
      ),
    );
    _indexDataRepo
        .getPortfolioPageInfo(portfolioItems: portfolioItems)
        .then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
