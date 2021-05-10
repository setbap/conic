import 'package:bloc/bloc.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/manager/manager.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';

class BuyPagePageDataCubit extends Cubit<GenericPageStete<BuyPageDataModel>> {
  final IndexDataRepository _indexDataRepo;
  final TransactionManager _transactionManager;
  BuyPagePageDataCubit({
    required IndexDataRepository indexDataRepo,
    required TransactionManager transactionManager,
  })  : _indexDataRepo = indexDataRepo,
        _transactionManager = transactionManager,
        super(
          GenericPageStete<BuyPageDataModel>(
            error: "",
            isLoading: true,
          ),
        );

  void addTransaction({required CoinTransactionStatus transactionStatus}) {
    final data = state.data!;
    _transactionManager.addTransaction(
      transactionStorage: data.toTransactionStorage(
        coinTransactionStatus: transactionStatus,
      ),
      transactionStatus: transactionStatus,
    );
  }

  void sellAll({required String coinId}) {
    _transactionManager.sellAll(coinId: coinId);
  }

  void updateBuyCoinData(BuyPageDataModel data) {
    emit(
      state.copyWith(
        data: data,
        error: '',
      ),
    );
  }

  void getBuyCoinData({required String coinId}) async {
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
