import 'package:bloc/bloc.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';

class ListPageDataCubit extends Cubit<GenericPageStete<ListPageDataModel>> {
  final IndexDataRepository _indexDataRepo;
  ListPageDataCubit({
    required IndexDataRepository indexDataRepo,
  })  : _indexDataRepo = indexDataRepo,
        super(
          GenericPageStete<ListPageDataModel>(
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
    _indexDataRepo.getListPageInfo().then((value) {
      emit(state.copyWith(data: value));
    }).catchError((err) {
      emit(state.copyWith(isError: true, error: "new error"));
    }).whenComplete(() {
      emit(state.copyWith(isLoading: false));
    });
  }
}
