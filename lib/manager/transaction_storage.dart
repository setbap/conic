import 'package:conic/models/models.dart';
import 'package:hive/hive.dart';

class TransactionManager {
  static final TransactionManager _instance = TransactionManager._internal();
  final Box<PortfolioStorage> portfolioStorageBox =
      Hive.box<PortfolioStorage>(PortfolioStorage.PortfolioKey);

  final Box<TransactionStorage> transactionStorageBox =
      Hive.box<TransactionStorage>(TransactionStorage.TransactionKey);

  factory TransactionManager() {
    return _instance;
  }

  TransactionManager._internal();

  void addTransaction({
    required TransactionStorage transactionStorage,
    required CoinTransactionStatus transactionStatus,
  }) {
    final isNegetive = transactionStatus == CoinTransactionStatus.Sell ||
            (transactionStatus == CoinTransactionStatus.Transfer ||
                transactionStorage.transferStatus == TransferStatus.TransferOut)
        ? -1
        : 1;
    final before = portfolioStorageBox.get(transactionStorage.id);
    final count = transactionStorage.count * isNegetive;
    final price = transactionStorage.price * isNegetive;
    transactionStorageBox.put(
      transactionStorage.id + "__" + DateTime.now().toString(),
      transactionStorage.copyWith(
        count: count,
        price: price,
      ),
    );
    if (before == null) {
      portfolioStorageBox.put(
        transactionStorage.id,
        PortfolioStorage(
          id: transactionStorage.id,
          name: transactionStorage.name,
          image: transactionStorage.image,
          symbol: transactionStorage.symbol,
          price: price,
          count: count,
        ),
      );
    } else {
      portfolioStorageBox.put(
        transactionStorage.id,
        PortfolioStorage(
          id: transactionStorage.id,
          name: transactionStorage.name,
          image: transactionStorage.image,
          symbol: transactionStorage.symbol,
          price: before.price + price,
          count: before.count + count,
        ),
      );
      if (before.price + price == 0) {
        portfolioStorageBox.delete(transactionStorage.id);
      }
    }
  }

  void sellAll({required String coinId}) {
    final before = portfolioStorageBox.get(coinId);
    if (before == null) {
      return;
    }
    final count = before.count * -1;
    final price = before.price * -1;
    transactionStorageBox.put(
      coinId + "__" + DateTime.now().toString(),
      TransactionStorage(
          name: before.name,
          desc: "Delete This Item",
          fee: 0,
          id: before.id,
          symbol: before.symbol,
          time: DateTime.now(),
          image: before.image,
          transferStatus: count > 0
              ? TransferStatus.TransferOut
              : TransferStatus.TransferIn,
          count: count,
          price: price,
          coinTransactionStatus: CoinTransactionStatus.Sell),
    );
    portfolioStorageBox.delete(coinId);
  }
}
