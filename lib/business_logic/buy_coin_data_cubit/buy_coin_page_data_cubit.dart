import 'package:bloc/bloc.dart';
import 'package:conic/business_logic/business_logic.dart';
import 'package:conic/models/models.dart';
import 'package:conic/repositories/repositories.dart';
import 'package:hive/hive.dart';

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

  void addTransaction({required CoinTransactionStatus transactionStatus}) {
    final box = Hive.box<PortfolioStorage>(PortfolioStorage.PortfolioKey);
    final data = state.data!;
    final isNegetive = transactionStatus == CoinTransactionStatus.Buy ||
        (transactionStatus == CoinTransactionStatus.Transfer ||
            state.data?.transferType == TransferStatus.TransferOut);
    box.put(
        data.id,
        PortfolioStorage(
          id: data.id,
          name: data.name,
          image: data.image,
          symbol: data.symbol,
          price: isNegetive ? -1 * data.price : data.price,
          fee: data.fee,
          desc: data.desc,
          count: data.count,
        ));
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
